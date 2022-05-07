//
//  
//  AndesModalView.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 4/05/22.
//
//

import UIKit

/**
 Internal protocol that specifies the behaviour a view must provide to be a valid representation of an AndesModal
 */
internal protocol AndesModalView: UIView {
    var delegate: AndesModalViewDelegate? { get set }
    func update(withConfig config: AndesModalViewConfig)
}

internal protocol AndesModalViewDelegate: NSObjectProtocol {
    func andesModalViewDidDissmis(_ view: AndesModalView)
}
