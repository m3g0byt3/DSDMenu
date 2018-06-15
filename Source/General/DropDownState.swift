//
//  DropDownState.swift
//  DropDownButton
//
//  Created by m3g0byt3 on 08/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

/// State of `DropDownMenu` instance, currently supported states are `.collapsed` and `.expanded`.
public enum DropDownState {
    
    case collapsed, expanded

    /// Change menu's state (`.collapsed` to `.expanded` and vice versa).
    mutating func toggle() {
        switch self {
        case .collapsed: self = .expanded
        case .expanded: self = .collapsed
        }
    }
}
