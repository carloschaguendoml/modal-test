//
//  File.swift
//  TestView
//
//  Created by Carlos Ml on 6/05/22.
//  Copyright © 2022 Mercado Libre. All rights reserved.
//

import UIKit

extension UIView {
    
    func autoPinEdgesToSuperviewEdges() {
        guard let superview = superview else {
            return
        }
        NSLayoutConstraint.activate([
            trailingAnchor.constraint(equalTo:  superview.trailingAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
}
