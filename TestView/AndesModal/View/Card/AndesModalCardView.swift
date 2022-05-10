//
//  
//  AndesModalViewDefault.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 4/05/22.
//
//

import UIKit

class AndesModalCardView: AndesModalAbstractView {
    
    override func updateView() {
        // Los card tiene el boton de cerrar por fuera del body
        contentView.allowCloseButton = false
        
        super.updateView()

        contentView.layoutMargins.top = 0
        contentView.layoutMargins.left = 22
        contentView.layoutMargins.right = 22
        contentView.layoutMargins.bottom = 20
        
        contentView.imageLayoutMargins = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)
    }

}
