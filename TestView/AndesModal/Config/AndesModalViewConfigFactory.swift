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
        return config
    }
}
