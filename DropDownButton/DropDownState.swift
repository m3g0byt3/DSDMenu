//
//  DropDownState.swift
//  DropDownButton
//
//  Created by m3g0byt3 on 08/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

public enum DropDownState {
    
    case collapsed, expanded
    
    mutating func toggle() {
        switch self {
        case .collapsed: self = .expanded
        case .expanded: self = .collapsed
        }
    }
}
