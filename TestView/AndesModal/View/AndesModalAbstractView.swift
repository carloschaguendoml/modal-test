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
       // super.xibSetup()
        translatesAutoresizingMaskIntoConstraints = false
        updateView()
    }

    /// Override this method on each Badge View to setup its unique components
    func updateView() {
        self.backgroundColor = config.layout.overlayColor
        contentView.imageSize = config.imageSize
        contentView.distribution = config.verticalAlignmet
        contentView.textAlignment = config.textAlignmet
        
        if let source = config.content.first {
            contentView.title = source.title
            contentView.body = source.body
        }

       // self.componentView.layoutMargins = config.layout.inset
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = config.layout.cornerRadius
        
        contentView.fixedTitleView.closeButton.addTarget(self, action: #selector(dissmisAction(_:)), for: .touchUpInside)
    }
    
    @IBAction func dissmisAction(_ sender: Any) {
        delegate?.andesModalViewDidDissmis(self)
    }
}


