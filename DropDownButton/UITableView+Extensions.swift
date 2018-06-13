//
//  UITableView+Extensions.swift
//  DropDownButton
//
//  Created by m3g0byt3 on 03/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

/// Helper struct, used to register `UINib` instance (if available) from given class or this class itself.
struct CellClassWrapper {

    private static let nibType = "nib"

    /// Wrapped class
    let cellClass: AnyClass?
    
    fileprivate var nib: UINib? {
        return cellClass
            .map( String.init(describing:) )
            .flatMap { Bundle.main.path(forResource: $0, ofType: CellClassWrapper.nibType) }
            .flatMap( URL.init )
            .map { $0.deletingPathExtension().lastPathComponent }
            .map { UINib(nibName:$0, bundle: nil) }
    }
}

extension UITableView {

    /**
     Register `UINib` instance (if available) provided by the class,
     wrapped in the `CellClassWrapper` instance or this class itself.
     - parameters:
        - wrapper: a `CellClassWrapper` instance
        - identifier: `UITableView` reuse identifier
     */
    func register(_ wrapper: CellClassWrapper, forCellReuseIdentifier identifier: String) {

        if let nib = wrapper.nib {
            register(nib, forCellReuseIdentifier: identifier)
        } else {
            register(wrapper.cellClass, forCellReuseIdentifier: identifier)
        }
    }
}
