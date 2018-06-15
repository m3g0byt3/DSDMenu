//
//  DropDownMenu+Extensions.swift
//  DropDownButton
//
//  Created by m3g0byt3 on 11/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

public extension DropDownMenu {

    /// Asks the delegate for the number of items in menu.
    @discardableResult
    func numberOfItems(_ number: Int) -> Self {
        _numberOfItems = number
        return self
    }

    /// Asks the delegate for the cell class used in menu.
    @discardableResult
    func cellClass(_ aClass: DropDownCell.Type) -> Self {
        _cellClass = aClass
        return self
    }

    /// Tells the delegate that the item in the menu was tapped.
    @discardableResult
    func didSelectItem(_ closure: @escaping (_ index: Int) -> Void) -> Self {
        _didSelectItem = closure
        return self
    }

    /// Tells the delegate that the cell in the menu is about to be displayed.
    @discardableResult
    func willDisplayCell(_ closure: @escaping (_ cell: DropDownCell, _ index: Int) -> Void) -> Self {
        _willDisplayCell = closure
        return self
    }

    /// Asks the delegate whether the menu should update thumbnail image automatically on selection.
    @discardableResult
    func updateThumbnailOnSelection(_ flag: Bool) -> Self {
        _updateThumbnailOnSelection = flag
        return self
    }
}
