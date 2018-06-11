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
    
    @IBOutlet private weak var dropDownWithNib: DropDownMenu! {
        didSet {
            dropDownWithNib.delegate = self
        }
    }
    
    @IBOutlet private weak var dropDownWithoutNib: DropDownMenu! {
        didSet {
            dropDownWithoutNib.delegate = self
        }
    }
    
    // MARK: - Properties
    
    private let fruits = [
        Meal(name: "Apple", image: #imageLiteral(resourceName: "apple")),
        Meal(name: "Pineapple", image: #imageLiteral(resourceName: "pineapple")),
        Meal(name: "Lemon", image: #imageLiteral(resourceName: "lemon")),
        Meal(name: "Melon", image: #imageLiteral(resourceName: "watermelon")),
        Meal(name: "Orange", image: #imageLiteral(resourceName: "orange")),
        Meal(name: "Pear", image: #imageLiteral(resourceName: "pear"))
    ]

    private let vegetables = [
        Meal(name: "Garlic", image: #imageLiteral(resourceName: "garlic")),
        Meal(name: "Aubergine", image: #imageLiteral(resourceName: "aubergine")),
        Meal(name: "Carrot", image: #imageLiteral(resourceName: "carrot")),
        Meal(name: "Potatoes", image: #imageLiteral(resourceName: "potatoes")),
        Meal(name: "Pepper", image: #imageLiteral(resourceName: "pepper")),
        Meal(name: "Onion", image: #imageLiteral(resourceName: "onion")),
        Meal(name: "Salad", image: #imageLiteral(resourceName: "salad"))
    ]

    // MARK: - IBActions

    @IBAction private func reset(_ sender: UIButton) {
        dropDownWithNib.clearThumbnail()
    }
}

// MARK: - DropDownDelegate protocol conformance

extension ViewController: DropDownDelegate {
    
    func cellClass(for dropDownMenu: DropDownMenu) -> DropDownCell.Type {
        
        switch dropDownMenu {
        case dropDownWithNib: return CustomDropDownCellWithNib.self
        case dropDownWithoutNib: return CustomDropDownCellWithoutNib.self
        default: preconditionFailure("Unknown DropDownMenu instance.")
        }
    }
    
    func dropDownMenu(_ dropDownMenu: DropDownMenu, willDisplay cell: DropDownCell, forRowAt index: Int) {
        switch cell {
        case let cell as CustomDropDownCellWithNib:
            let fruit = fruits[index]
            cell.configureUsing(fruit)
        case let cell as CustomDropDownCellWithoutNib:
            let vegetable = vegetables[index]
            cell.configureUsing(vegetable)
        default: break
        }
    }
    
    func numberOfItems(in dropDownMenu: DropDownMenu) -> Int {
        switch dropDownMenu {
        case dropDownWithNib: return fruits.count
        case dropDownWithoutNib: return vegetables.count
        default: preconditionFailure("Unknown DropDownMenu instance.")
        }
    }

    func updateThumbnailOnSelection(in dropDownMenu: DropDownMenu) -> Bool {
        if dropDownMenu == dropDownWithNib {
            return true
        }
        return false
    }
}
