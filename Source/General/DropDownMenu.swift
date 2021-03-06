//
//  DropDownMenu.swift
//  DropDownMenu
//
//  Created by m3g0byt3 on 27/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

/// A simple drop-down menu written in Swift.
open class DropDownMenu: UIButton {
    
    // MARK: - Types (internal usage only)
    
    private enum AnimationState {
        case beforeAnimation, afterAnimation
    }
    
    // MARK: - Constants (internal usage only)
    
    private static let heightToCornerRadiusRatio: CGFloat = 1 / 25
    private static let shadowOffset = CGSize(width: 1.0, height: 1.0)
    private static let shadowOpacity: Float = 1 / 3
    private static let shadowRadius: CGFloat = 5.0
    private static let shadowColor: UIColor = .black
    private static let animationDuration: TimeInterval = 0.3
    private static let heightConstraintMultiplier: CGFloat = 1.0
    private static let cellIdentifier = "DropDownCell"
    private static let delegatePropertyName = "delegate"

    // MARK: - Public Properties

    // Little hacky, but allows to connect non-objc `delegate` property in the Interface Builder.
    #if TARGET_INTERFACE_BUILDER
    @IBOutlet private weak var delegate: AnyObject?
    #else

    /// Delegate that conforms to the `DropDownDelegate` protocol.
    public weak var delegate: DropDownDelegate? {
        didSet {
            updateCellClass()
        }
    }
    #endif

    /// State of menu, currently supported states are `.collapsed` and `.expanded`.
    public var menuState: DropDownState = .collapsed

    // MARK: - Private Properties

    private let collapsedHeight: CGFloat = 0
    
    private var expandedHeight: CGFloat { return bounds.height * CGFloat(numberOfItems) }
    
    private var savedIndex = 0

    private var savedTitle = ""

    private var configurationCLosure: ((DropDownMenuConfigurator) -> Void)?
    
    private weak var heightConstraint: NSLayoutConstraint?
    
    private lazy var containerView: UIView = { this in
        this.layer.masksToBounds = false
        this.layer.shadowColor = DropDownMenu.shadowColor.cgColor
        this.layer.shadowOffset = DropDownMenu.shadowOffset
        this.layer.shadowOpacity = DropDownMenu.shadowOpacity
        this.layer.shadowRadius = DropDownMenu.shadowRadius
        this.addSubview(tableView)
        return this
    }(UIView())
    
    private lazy var tableView: UITableView = { this in
        this.dataSource = self
        this.delegate = self
        return this
    }(UITableView())

    private lazy var thumbnailImageView: UIImageView = { this in
        this.isUserInteractionEnabled = false
        this.contentMode = .scaleAspectFit
        return this
    }(UIImageView())

    /// - warning: ⚠️ Dispatched once ⚠️
    private lazy var setupConstraints: () -> Void = { [weak self] in
        tableView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: containerView,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .height,
                                            multiplier: DropDownMenu.heightConstraintMultiplier,
                                            constant: collapsedHeight)
        heightConstraint = constraint
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            containerView.topAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            constraint
        ])
        return {}
    }()

    // MARK: - Delegate/closure getters (internal usage only)

    private var numberOfItems: Int {
        return delegate?.numberOfItems(in: self) ?? _numberOfItems
    }

    private var cellClass: DropDownCell.Type {
        return delegate?.cellClass(for: self) ?? _cellClass
    }

    private var updateThumbnailOnSelection: Bool {
        return delegate?.updateThumbnailOnSelection(in: self) ?? _updateThumbnailOnSelection
    }

    private var didSelectItem: (_ menu: DropDownMenu, _ index: Int) -> Void {
        return delegate?.dropDownMenu ?? { [weak self] (_, index) in self?._didSelectItem?(index) }
    }

    private var willDisplayCell: (_ menu: DropDownMenu, _ cell: DropDownCell, _ index: Int) -> Void {
        return delegate?.dropDownMenu ?? { [weak self] (_, cell, index) in self?._willDisplayCell?(cell, index) }
    }

    // MARK: - Ivars for getters (internal usage only)

    // Have `internal` access modified because they should be available in extension.
    var _numberOfItems = 0
    var _cellClass = DropDownCell.self
    var _updateThumbnailOnSelection = false
    var _didSelectItem: ((_ index: Int) -> Void)?
    var _willDisplayCell: ((_ cell: DropDownCell, _ index: Int) -> Void)?

    // MARK: - Initialization

    public convenience init(title: String, frame: CGRect = CGRect.zero) {
        self.init(type: .system)
        self.frame = frame
        self.setTitle(title, for: .normal)
        self.setup()
    }

    // MARK: - Necessary Overriding
    
    // See https://developer.apple.com/library/content/qa/qa2013/qa1812.html for details.
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // Early exit if disabled, hidden or not visible
        let viewIsNotVisible = alpha <= 0.01
        if !isUserInteractionEnabled || isHidden || viewIsNotVisible {
            return nil
        }
        // Convert the point to the target view's coordinate system.
        // The target view isn't necessarily the immediate subview
        let convertedPoint = convert(point, to: tableView)
        
        if tableView.bounds.contains(convertedPoint) {
            // The target view may have its view hierarchy,
            // so call its hitTest method to return the right hit-test view
            return tableView.hitTest(convertedPoint, with: event)
        }
        
        return super.hitTest(point, with: event)
    }

    // Little hacky, but allows to connect non-objc `delegate` property in the Interface Builder.
    override open func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == DropDownMenu.delegatePropertyName {
            delegate = value as? DropDownDelegate
        } else {
            super.setValue(value, forUndefinedKey: key)
        }
    }

    // Perform internal setup when initialized in the Interface Builder
    override open func awakeFromNib() {
        setup()
    }

    // Update various non-AL UIs.
    override open func layoutSubviews() {
        super.layoutSubviews()
        // Set `separatorStyle = .none` at every subviews layout due to bug https://openradar.appspot.com/21940268
        tableView.separatorStyle = .none
        // Update tableView's row heigt
        tableView.rowHeight = frame.height
        // Update rounded corners for containerView and tableView
        containerView.layer.cornerRadius = containerView.bounds.width * DropDownMenu.heightToCornerRadiusRatio
        tableView.layer.cornerRadius = tableView.bounds.width * DropDownMenu.heightToCornerRadiusRatio
    }

    // Setup required constraints (once).
    override open func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }

    // Save assigned non-nil title.
    override open func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title, for: state)
        savedTitle = title ?? savedTitle
    }

    // MARK: - Public API

    /// Clears menu auto-generated thumbnail (if delegate allows auto-update) and sets back latest `title` value.
    open func clearThumbnail() {
        thumbnailImageView.image = nil
        setTitle(savedTitle, for: .normal)
    }

    /// Reload a `DropDownMenu` instance.
    open func reload() {
        let configurator = DropDownMenuConfigurator(wrapped: self)
        configurationCLosure?(configurator)
        updateCellClass()
        tableView.reloadData()
    }

    /**
     Menu uses closure passed to this method to configure itself if no delegate provided.

     Example of configuration closure:
     ```
     menu.configure { configurator in
        configurator.cellClass(DropDownCell.self)
                    .numberOfItems(10)
                    .updateThumbnailOnSelection(true)
                    .didSelectItem { index in print(index) }
                    .willDisplayCell { (cell, index) in print(cell, index) }
     }
     ```
     - parameter closure: Configuration closure that will be used instead of delegate.
     */
    open func configure(using closure: @escaping (DropDownMenuConfigurator) -> Void) {
        configurationCLosure = closure
        reload()
    }
    
    // MARK: - Private API
    
    private func setup() {
        addTarget(self, action: #selector(updateAppearance), for: .touchUpInside)
        addSubview(containerView)
        addSubview(thumbnailImageView)
        savedTitle = currentTitle ?? savedTitle
    }

    @objc private func updateAppearance() {
        let menuHeight = menuState == .collapsed ? expandedHeight : collapsedHeight

        let animations = {
            self.heightConstraint?.constant = menuHeight
            self.layoutIfNeeded()
        }

        let completion: (Bool) -> Void = { _ in
            self.updateViewHierarchy(.afterAnimation);
            self.menuState.toggle()
        }
        
        updateViewHierarchy(.beforeAnimation)
        layoutIfNeeded()
        UIView.animate(withDuration: DropDownMenu.animationDuration, animations: animations, completion: completion)
    }
    
    private func updateViewHierarchy(_ animationState: AnimationState) {
        guard let superview = superview else { return }

        switch (animationState, menuState) {
        case (.beforeAnimation, .collapsed):
            // It's safe to force unwrap here because we already have non-nil superview
            savedIndex = superview.subviews.index(of: self)!
            fallthrough
        case (.afterAnimation, .expanded):
            superview.exchangeSubview(at: superview.subviews.lastIndex, withSubviewAt: savedIndex)
        default: break
        }
    }

    private func updateCellClass() {
        let wrapper = CellClassWrapper(cellClass: cellClass)
        tableView.register(wrapper, forCellReuseIdentifier: DropDownMenu.cellIdentifier)
    }

    private func updateThumbnailUsingCellAt(_ indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? DropDownCell {
            setTitle(nil, for: .normal)
            thumbnailImageView.image = cell.thumbnailView.snapshotImage()
        }
    }
}

// MARK: - UITableViewDataSource protocol conformance

extension DropDownMenu: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: DropDownMenu.cellIdentifier, for: indexPath)
    }
}

// MARK: - UITableViewDelegate protocol conformance

extension DropDownMenu: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectItem(self, indexPath.row)

        if updateThumbnailOnSelection {
            updateThumbnailUsingCellAt(indexPath)
        }

        updateAppearance()
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? DropDownCell {
            willDisplayCell(self, cell, indexPath.row)
        }
    }
}
