//
//  
//  AndesModalFactory.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 4/05/22.
//
//

import Foundation

internal class AndesModalHierarchyFactory {
    static func provide(_ hierarchy: AndesModalHierarchy) -> AndesModalHierarchyProtocol {
        switch hierarchy {
        case .card:
            return AndesModalHierarchyCard()
        case .fullscreen:
            return AndesModalHierarchyFullScreen()
        }
    }
}
