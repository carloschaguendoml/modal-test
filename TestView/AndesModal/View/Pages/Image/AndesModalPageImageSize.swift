//
//  AndesModalPageImageSize.swift
//  TestView
//
//  Created by Carlos Ml on 5/05/22.
//

import UIKit

extension AndesModalPageImageView {
    
    enum ImageSize: Int {
        case tmb44
        case ilustration80
        case ilustration128
        case ilustration160
        case image
        
        var margins: UIEdgeInsets {
            switch self {
            case .ilustration80, .ilustration128, .ilustration160:
                return UIEdgeInsets(top: 24, left: 44, bottom: 0, right: 44)
            case .tmb44:
                return UIEdgeInsets(top: 24, left: 24, bottom: 0, right: 24)
            case .image:
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
        
        var height: CGFloat {
            switch self {
            case .ilustration80: return 80
            case .ilustration128: return 128
            case .ilustration160: return 160
            case .tmb44: return 44
            case .image: return 128
            }
        }
    }
}
