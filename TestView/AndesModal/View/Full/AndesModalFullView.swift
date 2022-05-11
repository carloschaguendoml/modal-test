//
//  AndesModalFullView.swift
//  AndesUI
//
//  Created by Carlos Chaguendo on 6/05/22.
//  Copyright © 2022 Mercado Libre. All rights reserved.
//

import UIKit

class AndesModalFullView: AndesModalAbstractView {
    
    @IBOutlet var stackView: UIStackView!
    
    override func updateView() {
        super.updateView()

        contentView.layoutMargins = UIEdgeInsets(top: 0, left: 22, bottom: 20, right: 22)
        contentView.imageLayoutMargins = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        
        
        /// para la variante carrusel  hay que agregar el footer a esta ventana y aggregar un inset bottom
        stackView.backgroundColor = .white
        stackView.layoutMargins.top = 40
        contentView.footerView = stackView
        
        contentView.updateLayout()
        
        
    }

}
