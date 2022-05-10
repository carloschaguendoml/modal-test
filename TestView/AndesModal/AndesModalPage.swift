//
//  AndesModalPage.swift
//  AndesUI
//
//  Created by Carlos Chaguendo on 6/05/22.
//  Copyright © 2022 Mercado Libre. All rights reserved.
//

import Foundation

@objc public class AndesModalPage: NSObject {
    
    public let title: String
    public let body: String
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }

}
