//
//  AndesModalPageImageSize.swift
//  TestView
//
//  Created by Carlos Ml on 5/05/22.
//

import UIKit

extension AndesModalImageView {
    
    enum ImageSize: Int {
        case tmb44
        case ilustration80
        case ilustration128
        case ilustration160
        case image
        case none
        
        var height: CGFloat {
            switch self {
            case .ilustration80: return 80
            case .ilustration128: return 128
            case .ilustration160: return 160
            case .tmb44: return 80
            case .image: return 128
            case .none: return 0
            }
        }
    }
}
