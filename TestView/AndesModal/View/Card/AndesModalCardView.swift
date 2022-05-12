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
    
    @IBOutlet var stackView: UIStackView!
    
    override func updateView() {
        super.updateView()
        
        let icon = UIImage(named: "close_24")?.withRenderingMode(.alwaysTemplate)
        
        dismissButton.setTitle("", for: .normal)
        dismissButton.setImage(icon, for: .normal)
        dismissButton.tintColor = .white
        dismissButton.isHidden = !config.allowsCloseButton
        dismissButton.transform = .init(translationX: 24/2, y: 0)
        
        // Los card tiene el boton de cerrar por fuera del body
        contentView.allowsCloseButton = false
        
        contentView.layoutMargins.top = 0
        contentView.layoutMargins.left = 22
        contentView.layoutMargins.right = 22
        contentView.layoutMargins.bottom = 20
        
        contentView.imageLayoutMargins = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)
        contentView.footerLayoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)

        stackView.backgroundColor = .white
        contentView.footerView = stackView
        contentView.updateLayout()
    }

}
