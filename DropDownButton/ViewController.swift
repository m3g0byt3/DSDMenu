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
    
    private let models = [
        Fruit(name: "Apple", image: #imageLiteral(resourceName: "apple")),
        Fruit(name: "Pineapple", image: #imageLiteral(resourceName: "pineapple")),
        Fruit(name: "Lemon", image: #imageLiteral(resourceName: "lemon")),
        Fruit(name: "Melon", image: #imageLiteral(resourceName: "watermelon")),
        Fruit(name: "Raspberry", image: #imageLiteral(resourceName: "raspberry")),
        Fruit(name: "Orange", image: #imageLiteral(resourceName: "orange")),
        ]
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
        let model = models[index]
        guard let customCell = cell as? CustomDropDownCellWithNib else { return }
        
        customCell.configureUsing(model)
    }
    
    func numberOfItems(in dropDownMenu: DropDownMenu) -> Int {
        
        switch dropDownMenu {
        case dropDownWithNib: return models.count
        case dropDownWithoutNib: return 3
        default: preconditionFailure("Unknown DropDownMenu instance.")
        }
    }
}
