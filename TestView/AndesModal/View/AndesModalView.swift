//
//  
//  AndesModalView.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 4/05/22.
//
//

import UIKit

internal protocol AndesModalView: UIView {
    var delegate: AndesModalViewDelegate? { get set }
    func update(withConfig config: AndesModalViewConfig)
}

internal protocol AndesModalViewDelegate: NSObjectProtocol {
    func andesModalViewDidDissmis(_ view: AndesModalView)
}
