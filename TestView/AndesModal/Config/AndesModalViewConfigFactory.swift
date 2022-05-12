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
        config.imageStyle = modal.imageStyle
        config.isFixedTitleEnabled = modal.isFixedTitleEnabled
        config.isFixedFooterEnabled = modal.isFixedFooterEnabled
        config.source = modal.pages
        config.allowsCloseButton = modal.allowsCloseButton
        
        switch modal.hierarchy {
        case .card:
            config.textAlignmet = .center
            config.verticalAlignmet = .top
            
        case .fullscreen:
            config.textAlignmet = modal.imageStyle == .none ? .left : .center
            config.verticalAlignmet = modal.imageStyle == .none ? AndesModalVerticalAlignment.top : AndesModalVerticalAlignment.middle
        }
        
        return config
    }
}
