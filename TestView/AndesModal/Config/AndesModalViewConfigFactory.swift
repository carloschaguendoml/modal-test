//
//  
//  AndesModalViewConfigFactory.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 4/05/22.
//
//

import Foundation

internal class AndesModalViewConfigFactory {
    
    static func provideInternalConfig(for modal: AndesModal) -> AndesModalViewConfig {
        let hierarchyIns = AndesModalHierarchyFactory.provide(modal.hierarchy)
        var config = AndesModalViewConfig(hierarchy: hierarchyIns)
        config.imageSize = modal.imageSize
        config.stickHeader = modal.stickHeader
        config.stickFooter = modal.stickFooter
        config.verticalAlignmet = modal.verticalAlignmet
        config.textAlignmet =  modal.textAlignmet
        config.source = modal.pages
        config.allowsDismissButton = modal.allowsDismissButton
        
        switch modal.hierarchy {
        case .card:
            config.textAlignmet = .center
            
        case .fullscreen:
            config.textAlignmet = modal.imageSize == .none ? .left : .center
            config.verticalAlignmet = modal.imageSize == .none ? AndesModalVerticalAlignment.top : AndesModalVerticalAlignment.middle
        }
        
        return config
    }
}
