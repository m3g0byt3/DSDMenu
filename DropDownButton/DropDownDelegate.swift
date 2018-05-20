//
//  DropDownDelegate.swift
//  DropDownMenu
//
//  Created by m3g0byt3 on 10/05/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

@objc
public protocol DropDownDelegate: NSObjectProtocol {
    
    /**
     Required method, provides number of items in menu
     - parameter DropDownMenu: DropDownMenu instance
     - returns: number of items in menu
     */
    func numberOfItems(in dropDownMenu: DropDownMenu) -> Int
    
    /**
     Optional method, called when user selects item in menu.
     
     Default implementation does nothing.
     - parameters:
     - dropDownMenu: DropDownMenu instance
     - index: Index
     */
    func dropDownMenu(_ dropDownMenu: DropDownMenu, didSelectItemAt index: Int)
}

extension DropDownDelegate {
    
    // Default implementation for `dropDownMenu(_:didSelectItemAt:), does nothing`
    func dropDownMenu(_ dropDownMenu: DropDownMenu, didSelectItemAt index: Int) {}
}
