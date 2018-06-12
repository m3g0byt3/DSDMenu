//
//  DropDownMenu+Extensions.swift
//  DropDownButton
//
//  Created by m3g0byt3 on 11/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

public extension DropDownMenu {

    @discardableResult
    func numberOfItems(_ number: Int) -> Self {
        _numberOfItems = number
        return self
    }

    @discardableResult
    func cellClass(_ aClass: DropDownCell.Type) -> Self {
        _cellClass = aClass
        return self
    }

    @discardableResult
    func didSelectItem(_ closure: @escaping (_ index: Int) -> Void) -> Self {
        _didSelectItem = closure
        return self
    }

    @discardableResult
    func willDisplayCell(_ closure: @escaping (_ cell: DropDownCell, _ index: Int) -> Void) -> Self {
        _willDisplayCell = closure
        return self
    }
    
    @discardableResult
    func updateThumbnailOnSelection(_ flag: Bool) -> Self {
        _updateThumbnailOnSelection = flag
        return self
    }
}
