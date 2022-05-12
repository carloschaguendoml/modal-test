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
    static func provide(_ hierarchy: AndesModalType) -> AndesModalTypeProtocol {
        switch hierarchy {
        case .card:
            return AndesModalTypeCard()
        case .fullscreen:
            return AndesModalTypeFullScreen()
        }
    }
}
