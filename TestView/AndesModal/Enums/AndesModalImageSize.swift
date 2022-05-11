//
//  AndesModalPageImageSize.swift
//  AndesUI
//
//  Created by Carlos Chaguendo on 5/05/22.
//

import UIKit

public enum AndesModalImageStyle: Int {
    case tmb
    case ilustration80
    case ilustration128
    case ilustration160
    case banner
    case none

     var height: CGFloat {
         switch self {
         case .ilustration80: return 80
         case .ilustration128: return 128
         case .ilustration160: return 160
         case .tmb: return 80
         case .banner: return 128
         case .none: return 0
         }
     }
}
