//
//  DropDownMenu.swift
//  DropDownMenu
//
//  Created by m3g0byt3 on 27/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

open class DropDownMenu: UIButton {

    // MARK: - Constants

    private static let heightToCornerRadiusRatio: CGFloat = 1 / 25
    private static let shadowOffset = CGSize(width: 1.0, height: 1.0)
    private static let shadowOpacity: Float = 1 / 3
    private static let shadowRadius: CGFloat = 5.0
    private static let shadowColor: UIColor = .black
    private static let animationDuration: TimeInterval = 0.3
    private static let heightConstraintMultiplier: CGFloat = 1.0
    private static let cellIdentifier = "cell"

    // MARK: IBOutlets

    @IBOutlet public weak var delegate: DropDownDelegate?

    // MARK: - Properties

    public var selectedItemIndex = 0 {
        didSet {
            updateView()
        }
    }
    private let collapsedHeight: CGFloat = 0
    private var expandedHeight: CGFloat {
        let rows = delegate?.numberOfItems(in: self) ?? 0
        return bounds.height * CGFloat(rows)

    }

    private weak var heightConstraint: NSLayoutConstraint!

    private lazy var containerView: UIView = { this in
        this.layer.masksToBounds = false
        this.layer.shadowColor = DropDownMenu.shadowColor.cgColor
        this.layer.shadowOffset = DropDownMenu.shadowOffset
        this.layer.shadowOpacity = DropDownMenu.shadowOpacity
        this.layer.shadowRadius = DropDownMenu.shadowRadius
        return this
    }(UIView())

    private lazy var tableView: UITableView = { this in
        this.dataSource = self
        this.delegate = self
        this.register(UITableViewCell.self, forCellReuseIdentifier: DropDownMenu.cellIdentifier)
        return this
    }(UITableView())

    // MARK: - Inits

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Public API

    // See https://developer.apple.com/library/content/qa/qa2013/qa1812.html for details.
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // Convert the point to the target view's coordinate system.
        // The target view isn't necessarily the immediate subview
        let convertedPoint = self.convert(point, to: tableView)

        if tableView.bounds.contains(convertedPoint) {
            // The target view may have its view hierarchy,
            // so call its hitTest method to return the right hit-test view
            return tableView.hitTest(convertedPoint, with: event)
        }

        return super.hitTest(point, with: event)
    }

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

    // MARK: - Private API

    private func setup() {
        addTarget(self, action: #selector(selectionHandler), for: .touchUpInside)
        containerView.addSubview(tableView)
        addSubview(containerView)
        setupConstraints()
    }

    // FIXME: remove this!
    private func test() {
        layoutIfNeeded()
        let cell = UITableViewCell(frame: frame)
        cell.textLabel?.text = "#\(selectedItemIndex)"
//        cell.imageView?.image = DropDownMenu.images[selectedItemIndex]
        let snapshot = cell.snapshotImage()
        setImage(snapshot?.withRenderingMode(.alwaysOriginal), for: .normal)

        // FIXME: remove this!
        let title = titleLabel?.text?.appending(" ▼")
        titleLabel?.text = title
        setTitle(title, for: .normal)
        //        updateTitle()
    }

    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        heightConstraint = NSLayoutConstraint(item: containerView,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .height,
                                              multiplier: DropDownMenu.heightConstraintMultiplier,
                                              constant: collapsedHeight)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            containerView.topAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heightConstraint
        ])
    }

    @objc private func selectionHandler() {
        let isExpanded = self.heightConstraint.constant > self.collapsedHeight

        layoutIfNeeded()
        UIView.animate(withDuration: DropDownMenu.animationDuration) { [unowned self] in
            self.heightConstraint.constant = isExpanded ? self.collapsedHeight : self.expandedHeight
            self.layoutIfNeeded()
            self.updateTitle()
        }
    }

    private func updateView() {
        let index = IndexPath(row: selectedItemIndex, section: 0)
        let cell = tableView.cellForRow(at: index)
        if let snapshot = cell?.snapshotImage(), snapshot.size.width > 0, snapshot.size.height > 0 {
            setImage(snapshot.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }

    private func updateTitle() {
        // FIXME: remove this!
        let isExpanded = self.heightConstraint.constant > self.collapsedHeight

        let suffix = isExpanded ? "▲" : "▼"
        var newTitle = title(for: .normal)
        newTitle?.removeLast()
        newTitle?.append(suffix)
        setTitle(newTitle, for: .normal)
    }
}

// MARK: - UITableViewDataSource protocol conformance

extension DropDownMenu: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.numberOfItems(in: self) ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Configure cell with closure from delegate!
        let cell = tableView.dequeueReusableCell(withIdentifier: DropDownMenu.cellIdentifier, for: indexPath)
        let index = indexPath.row
//        cell.selectionStyle = .none
        cell.textLabel?.text = "#\(index)"
//        cell.imageView?.image = DropDownMenu.images[index]
        return cell
    }
}

// MARK: - UITableViewDelegate protocol conformance

extension DropDownMenu: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectionHandler()
//        selectedItemIndex = indexPath.row
        delegate?.dropDownMenu(self, didSelectItemAt: indexPath.row)
    }
}
