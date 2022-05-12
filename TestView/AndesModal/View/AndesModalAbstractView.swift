//
//  
//  AndesModalAbstractView.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 4/05/22.
//
//

import UIKit

class AndesModalAbstractView: UIViewXIB, AndesModalView {
    
    @IBOutlet weak var contentView: AndesModalBodyView!
    
    weak var delegate: AndesModalViewDelegate?
    var config: AndesModalViewConfig
    
    init(withConfig config: AndesModalViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        config = AndesModalViewConfig()
        super.init(coder: coder)
        setup()
    }

    func update(withConfig config: AndesModalViewConfig) {
        self.config = config
        updateView()
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        updateView()
    }

    func updateView() {
        self.backgroundColor = config.layout.overlayColor
        contentView.allowsCloseButton = config.allowsCloseButton
        contentView.imageStyle = config.imageStyle
        contentView.distribution = config.verticalAlignmet
        contentView.textAlignment = config.textAlignmet
        contentView.isFixedTitleEnabled = config.isFixedTitleEnabled
        contentView.isFixedFooterEnabled = config.isFixedFooterEnabled
        
        if let source = config.source.first {
            contentView.title = source.title
            contentView.body = source.body
        }

        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = config.layout.cornerRadius
    }
    
    @IBAction func dissmisAction(_ sender: Any) {
        delegate?.andesModalViewDidDissmis(self)
    }
}
