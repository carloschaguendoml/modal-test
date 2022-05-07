//
//  AndesModalPageTopAlignView.swift
//  TestView
//
//  Created by Carlos Ml on 5/05/22.
//

import UIKit

internal class AndesModalPageContentView: UIViewXIB {
    
    @IBOutlet weak private(set) var imageView: AndesModalPageImageView!
    @IBOutlet weak private(set) var titleLabel: UILabel!
    @IBOutlet weak private(set) var bodyLabel: UILabel!
    
    @IBInspectable internal var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue}
    }
    
    @IBInspectable internal var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue}
    }
    
    @IBInspectable internal var body: String? {
        get { bodyLabel.text }
        set { bodyLabel.text = newValue}
    }
    
    internal var textAlignment: NSTextAlignment! {
        didSet {
            titleLabel.textAlignment = textAlignment
            bodyLabel.textAlignment = textAlignment
        }
    }
    
    internal var imageSize: AndesModalPageImageView.ImageSize {
        get { imageView.size }
        set { imageView.size = newValue}
    }
    
    
}

extension AndesModalPageContentView {
    
    @available(*, unavailable, message: "support only to interfaz builder")
    @IBInspectable var ibMode: Int {
        set {
            print("Set ib mode", newValue)
            guard let mode = AndesModalPageImageView.ImageSize(rawValue: newValue) else {
                fatalError()
            }
            print("Set ib 2", newValue)
            self.imageView.size = mode
        }
        get {
            self.imageView.size.rawValue
        }
    }
    
}

