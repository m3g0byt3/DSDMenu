//
//  AbstractExampleViewController.swift
//  DropDownButton
//
//  Created by m3g0byt3 on 12/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit
import DSDMenu

class AbstractExampleViewController: UIViewController {

    // MARK: - Properties

    class var defaultTitle: String {
        preconditionFailure("Must be implemented by subclass!")
    }

    // MARK: - IBOutlets

    @IBOutlet weak var menu: DropDownMenu!
    @IBOutlet weak var imageView: UIImageView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - IBActions

    @IBAction func clear(_ sender: UIBarButtonItem) {
        menu.reload()
        resetUI()
    }

    // MARK: - Private API

    func setupUI() {
        navigationItem.title = NewViewController.defaultTitle
    }

    func resetUI() {
        navigationItem.title = nil
        imageView.image = nil
        navigationItem.title = NewViewController.defaultTitle
    }
}
