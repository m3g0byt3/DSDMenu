//
//  NewViewController.swift
//  DropDownButton
//
//  Created by m3g0byt3 on 12/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

final class NewViewController: AbstractExampleViewController {

    // MARK: - Properties

    override class var defaultTitle: String {
        return "Select vegetable from menu"
    }

    let meals = [
        Meal(name: "Garlic", image: #imageLiteral(resourceName: "garlic")),
        Meal(name: "Aubergine", image: #imageLiteral(resourceName: "aubergine")),
        Meal(name: "Carrot", image: #imageLiteral(resourceName: "carrot")),
        Meal(name: "Potatoes", image: #imageLiteral(resourceName: "potatoes")),
        Meal(name: "Pepper", image: #imageLiteral(resourceName: "pepper")),
        Meal(name: "Onion", image: #imageLiteral(resourceName: "onion")),
        Meal(name: "Salad", image: #imageLiteral(resourceName: "salad"))
    ]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenu()
    }

    // MARK: - Private API

    private func setupMenu() {
        menu.configure { [unowned self] configurator in
            configurator.cellClass(CustomDropDownCellWithoutNib.self)
                        .numberOfItems(self.meals.count)
                        .updateThumbnailOnSelection(false)
                        .didSelectItem { index in
                            let meal = self.meals[index]
                            self.navigationItem.title = meal.name
                            self.imageView.image = meal.image
                        }
                        .willDisplayCell { (cell, index) in
                            let meal = self.meals[index]
                            if let cell = cell as? CustomDropDownCellWithoutNib {
                                cell.configureUsing(meal)
                            }
                        }
        }
    }
}
