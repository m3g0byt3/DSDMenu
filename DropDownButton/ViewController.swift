//
//  ViewController.swift
//  DropDownMenu
//
//  Created by m3g0byt3 on 27/04/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var dropDown: DropDownMenu!

    // MARK: - Properties

    private let model = [
        Fruit(name: "Apple", image: #imageLiteral(resourceName: "apple")),
        Fruit(name: "Pineapple", image: #imageLiteral(resourceName: "pineapple")),
        Fruit(name: "Lemon", image: #imageLiteral(resourceName: "lemon")),
        Fruit(name: "Melon", image: #imageLiteral(resourceName: "watermelon")),
        Fruit(name: "Raspberry", image: #imageLiteral(resourceName: "raspberry")),
        Fruit(name: "Orange", image: #imageLiteral(resourceName: "orange")),
        ]
}
