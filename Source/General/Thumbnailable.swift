//
//  Thumbnailable.swift
//  DropDownButton
//
//  Created by m3g0byt3 on 11/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

/// Objects that conforms to this protocol - must provide thumbnail (a `UIVIew` instance).
public protocol Thumbnailable {

    /// Thumbnail (a `UIVIew` instance).
    var thumbnailView: UIView { get }
}

public extension Thumbnailable where Self: DropDownCell {

    var thumbnailView: UIView {
        return contentView
    }
}
