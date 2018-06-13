//
//  Array+Extensions.swift
//  DropDownButton
//
//  Created by m3g0byt3 on 11/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

extension Array {

    /// The last valid subscript argument in the array. Returns `0` if array is empty.
    var lastIndex: Int {
        return count > 0 ? endIndex - 1 : 0
    }
}
