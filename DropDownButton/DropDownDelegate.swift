//
//  DropDownDelegate.swift
//  DropDownMenu
//
//  Created by m3g0byt3 on 10/05/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

public protocol DropDownDelegate: class {

    /**
     Required method, provides number of items in menu
     - parameter DropDownMenu: DropDownMenu instance
     - returns: number of items in menu
     */
    func numberOfItems(in dropDownMenu: DropDownMenu) -> Int

    /**
     Optional method, returns type of cell used in DropDownMenu.

     Default implementation returns `DropDownCell.self`.
     - parameter dropDownMenu: DropDownMenu instance
     */
    func cellClass(for dropDownMenu: DropDownMenu) -> DropDownCell.Type

    /**
     Optional method, called when user selects item in menu.

     Default implementation does nothing.
     - parameters:
        - dropDownMenu: DropDownMenu instance
        - index: Index
     */
    func dropDownMenu(_ dropDownMenu: DropDownMenu, didSelectItemAt index: Int)

    /**
     Optional method, called when menu is ready to display a cell.

     Default implementation does nothing.
     - parameters:
        - dropDownMenu: DropDownMenu instance
        - cell: DropDownCell instance
        - index: Index
     */
    func dropDownMenu(_ dropDownMenu: DropDownMenu, willDisplay cell: DropDownCell, forRowAt index: Int)
}

extension DropDownDelegate {

    // Default implementation for `cellClass(for:)`, returns `DropDownCell.self`.
    func cellClass(for dropDownMenu: DropDownMenu) -> DropDownCell.Type { return DropDownCell.self }

    // Default implementation for `dropDownMenu(_:didSelectItemAt:)`, does nothing.
    func dropDownMenu(_ dropDownMenu: DropDownMenu, didSelectItemAt index: Int) {}

    // Default implementation for `dropDownMenu(_:willDisplay:forRowAt:), does nothing.`
    func dropDownMenu(_ dropDownMenu: DropDownMenu, willDisplay cell: DropDownCell, forRowAt index: Int) {}
}
