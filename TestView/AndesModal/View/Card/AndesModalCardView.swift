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
    
    @IBOutlet weak var dismissButton: UIButton!
    
    override func updateView() {
        super.updateView()
        
        // Los card tiene el boton de cerrar por fuera del body
        contentView.allowCloseButton = false
        
        dismissButton.isHidden = !config.allowsDismissButton

        contentView.layoutMargins.top = 0
        contentView.layoutMargins.left = 22
        contentView.layoutMargins.right = 22
        contentView.layoutMargins.bottom = 20
        
        contentView.imageLayoutMargins = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)
        contentView.updateLayout()
    }

}
