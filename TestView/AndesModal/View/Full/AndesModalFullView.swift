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
        contentView.imageLayoutMargins = UIEdgeInsets(top: 0, left: 22, bottom: 10, right: 22)
        contentView.footerLayoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 20)
        
        
        /// para la variante carrusel  hay que agregar el footer a esta ventana y aggregar un inset bottom
        stackView.backgroundColor = .white
        stackView.layoutMargins.top = 40
        contentView.footerView = stackView
        
        contentView.updateLayout()
        
        
    }

}
