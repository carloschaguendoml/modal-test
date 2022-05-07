//
//  
//  AndesModalViewConfig.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 4/05/22.
//
//

import Foundation
import UIKit

/// used to define the ui of internal AndesModal views
internal struct AndesModalViewConfig {
    
    var layout: AndesModalHierarchyProtocol
    var imageSize: AndesModalPageImageView.ImageSize = .ilustration128
    var stickHeader = false
    var stickFooter = false
    var textAlignmet = NSTextAlignment.left
    var verticalAlignmet = AndesModalPageAbstractView.Distribution.center
    
    init() {
        layout = AndesModalHierarchyCard()
    }

    init(hierarchy: AndesModalHierarchyProtocol) {
        self.layout = hierarchy
    }
}
