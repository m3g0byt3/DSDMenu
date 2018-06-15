//
//  DropDownMenuConfigurator.swift
//  DSDMenu
//
//  Created by m3g0byt3 on 13/06/2018.
//

import Foundation

/**
 Wrapper struct, used for menu configuration.
 Use available chainable methods to configure.
 */
public struct DropDownMenuConfigurator {

    private let menu: DropDownMenu

    init(wrapped: DropDownMenu) {
        menu = wrapped
    }
}

public extension DropDownMenuConfigurator {

    /// Asks the delegate for the number of items in menu.
    @discardableResult
    func numberOfItems(_ number: Int) -> DropDownMenuConfigurator {
        menu._numberOfItems = number
        return self
    }

    /// Asks the delegate for the cell class used in menu.
    @discardableResult
    func cellClass(_ aClass: DropDownCell.Type) -> DropDownMenuConfigurator {
        menu._cellClass = aClass
        return self
    }

    /// Tells the delegate that the item in the menu was tapped.
    @discardableResult
    func didSelectItem(_ closure: @escaping (_ index: Int) -> Void) -> DropDownMenuConfigurator {
        menu._didSelectItem = closure
        return self
    }

    /// Tells the delegate that the cell in the menu is about to be displayed.
    @discardableResult
    func willDisplayCell(_ closure: @escaping (_ cell: DropDownCell, _ index: Int) -> Void) -> DropDownMenuConfigurator {
        menu._willDisplayCell = closure
        return self
    }

    /// Asks the delegate whether the menu should update thumbnail image automatically on selection.
    @discardableResult
    func updateThumbnailOnSelection(_ flag: Bool) -> DropDownMenuConfigurator {
        menu._updateThumbnailOnSelection = flag
        return self
    }
}
