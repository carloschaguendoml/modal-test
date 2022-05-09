//
//  
//  AndesModalViewDefault.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 4/05/22.
//
//

import Foundation

class AndesModalCardView: AndesModalAbstractView {
    
    override func updateView() {
        super.updateView()
        // Los card tiene el boton de cerrar por fuera del body
        contentView.allowCloseButton = false
        
        contentView.fixedTitleView.layoutMargins.left = 22
        contentView.fixedTitleView.layoutMargins.right = 22
        
        contentView.layoutMargins.top = 0
        contentView.layoutMargins.left = 22
        contentView.layoutMargins.right = 22
        contentView.layoutMargins.bottom = 20
    }

}
