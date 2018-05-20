//
//  ConfigurableCell.swift
//  DropDownButton
//
//  Created by m3g0byt3 on 14/05/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import Foundation

protocol ConfigurableCell {
    
    associatedtype Model
    
    func configureUsing(_ model: Model)
}
