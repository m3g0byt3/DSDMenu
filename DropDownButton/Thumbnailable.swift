//
//  Thumbnailable.swift
//  DropDownButton
//
//  Created by m3g0byt3 on 11/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

protocol Thumbnailable {

    var thumbnailView: UIView { get }
}

extension Thumbnailable where Self: DropDownCell {

    var thumbnailView: UIView {
        return contentView
    }
}
