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

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var contentView: ScrollableStick!
    
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
        loadNib()
        translatesAutoresizingMaskIntoConstraints = false
        pinXibViewToSelf()
        updateView()
    }

    /// Override this method on each Badge View to setup its unique components
    func updateView() {
        self.backgroundColor = config.layout.overlayColor
        contentView.imageSize = config.imageSize
        contentView.distribution = config.verticalAlignmet
        contentView.textAlignment = config.textAlignmet
        
       // self.componentView.layoutMargins = config.layout.inset
        //self.containerView.clipsToBounds = true
       // self.containerView.layer.masksToBounds = true
       // self.containerView.layer.cornerRadius = config.layout.cornerRadius
        
        //contentView.contentView.imageSize = config.imageSize
        //contentView.distribution = config.verticalAlignmet
    }
    
    @IBAction func dissmisAction(_ sender: Any) {
        delegate?.andesModalViewDidDissmis(self)
    }
}


