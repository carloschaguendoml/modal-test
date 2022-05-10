//
//  AndesModalFullView.swift
//  AndesUI
//
//  Created by Carlos Chaguendo on 6/05/22.
//  Copyright © 2022 Mercado Libre. All rights reserved.
//

import UIKit

class AndesModalFullView: AndesModalAbstractView {
    
    override func updateView() {
        super.updateView()

        contentView.layoutMargins = UIEdgeInsets(top: 0, left: 22, bottom: 20, right: 22)
        contentView.imageLayoutMargins = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        
        let label = UILabel()
        label.text = "Esto es el fotter"
        label.backgroundColor = .red
        contentView.footerView = label
        
        contentView.updateLayout()
    }

}
