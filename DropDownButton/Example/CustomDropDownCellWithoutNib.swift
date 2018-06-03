//
//  CustomDropDownCellWithoutNib.swift
//  DropDownButton
//
//  Created by m3g0byt3 on 03/06/2018.
//  Copyright © 2018 m3g0byt3. All rights reserved.
//

import UIKit

final class CustomDropDownCellWithoutNib: DropDownCell {

    // MARK: - Inits

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("Not implemented!")
    }

    // MARK: - Private API

    private func setup() {
        backgroundColor = .red
    }
}
