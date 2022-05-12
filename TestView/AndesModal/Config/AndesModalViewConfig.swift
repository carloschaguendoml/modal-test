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
    
    var layout: AndesModalTypeProtocol
    var imageStyle: AndesModalImageStyle = .ilustration128
    var isFixedTitleEnabled = false
    var isFixedFooterEnabled = false
    var textAlignmet = NSTextAlignment.left
    var verticalAlignmet = AndesModalVerticalAlignment.middle
    var source: [AndesModalPage] = []
    var allowsCloseButton = true
    
    init() {
        layout = AndesModalTypeCard()
    }

    init(hierarchy: AndesModalTypeProtocol) {
        self.layout = hierarchy
    }
}
