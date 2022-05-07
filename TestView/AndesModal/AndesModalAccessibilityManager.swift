//
//  
//  AndesModalAccessibilityManager.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 4/05/22.
//
//

import UIKit

class AndesModalAccessibilityManager {
    private weak var view: AndesModal!
    
    required init(view: UIView) {
        guard let accessibleView = view as? AndesModal else {
            fatalError("AndesModal AccessibilityManager should recieve an AndesModal")
        }
        self.view = accessibleView
        viewUpdated()
    }
    
    func viewUpdated() {
        //here you should update the view's accessibility information
    }
    
    func accessibilityActivated() {
        //here you should Activate the main or secundary action of the component
    }
}
