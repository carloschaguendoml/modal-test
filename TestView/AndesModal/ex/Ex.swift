//
//  Ex.swift
//  TestView
//
//  Created by Carlos Andres Chaguendo Sanchez on 11/05/22.
//  Copyright © 2022 Mercado Libre. All rights reserved.
//

import UIKit

internal extension UIScrollView {

    var topFixedAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return frameLayoutGuide.topAnchor
        } else {
            guard let superview = superview else {
                preconditionFailure()
            }
            return superview.topAnchor
        }
    }

    var bottomFixedAnchor: NSLayoutYAxisAnchor {
       if #available(iOS 11.0, *) {
           return frameLayoutGuide.bottomAnchor
       } else {
           guard let superview = superview else {
               preconditionFailure()
           }
           return superview.bottomAnchor
       }
   }

}

internal extension UIEdgeInsets {
    var horizontally: CGFloat { self.left + self.right }
    var vertically: CGFloat { self.top + self.bottom }
}
