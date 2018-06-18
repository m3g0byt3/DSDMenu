//
//  OldViewController.swift
//  DropDownButton
//
//  Created by m3g0byt3 on 12/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit
import DSDMenu

final class OldWayViewController: AbstractExampleViewController {

    // MARK: - Properties

    override class var defaultTitle: String {
        return "Select fruit from the menu"
    }

    let meals = [
        Meal(name: "Apple", image: #imageLiteral(resourceName: "apple")),
        Meal(name: "Pineapple", image: #imageLiteral(resourceName: "pineapple")),
        Meal(name: "Lemon", image: #imageLiteral(resourceName: "lemon")),
        Meal(name: "Melon", image: #imageLiteral(resourceName: "watermelon")),
        Meal(name: "Orange", image: #imageLiteral(resourceName: "orange")),
        Meal(name: "Pear", image: #imageLiteral(resourceName: "pear"))
    ]

    // MARK: - IBActions

    @IBAction override func clear(_ sender: UIBarButtonItem) {
        super.clear(sender)
        menu.clearThumbnail()
    }
}

// MARK: - DropDownDelegate protocol conformance

extension OldWayViewController: DropDownDelegate {

    func numberOfItems(in dropDownMenu: DropDownMenu) -> Int {
        return meals.count
    }

    func updateThumbnailOnSelection(in dropDownMenu: DropDownMenu) -> Bool {
        return true
    }

    func cellClass(for dropDownMenu: DropDownMenu) -> DropDownCell.Type {
        return CustomDropDownCellWithNib.self
    }

    func dropDownMenu(_ dropDownMenu: DropDownMenu, didSelectItemAt index: Int) {
        let meal = meals[index]
        navigationItem.title = meal.name
        imageView.image = meal.image
    }

    func dropDownMenu(_ dropDownMenu: DropDownMenu, willDisplay cell: DropDownCell, forRowAt index: Int) {
        let meal = meals[index]
        if let cell = cell as? CustomDropDownCellWithNib {
            cell.configureUsing(meal)
        }
    }
}
