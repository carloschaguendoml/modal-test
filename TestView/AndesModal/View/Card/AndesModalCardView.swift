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
    }

}
