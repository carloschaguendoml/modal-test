//
//  AndesModalPageAbstractView.swift
//  TestView
//
//  Created by Carlos Ml on 5/05/22.
//

import UIKit

@IBDesignable class AndesModalPageAbstractView: UIViewXIB {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: AndesModalPageContentView!
    
    private var contentHeight: CGFloat = 0.0
    
   
    override public func layoutSubviews() {
        super.layoutSubviews()
        /// Permite que la vista trate de usar la maxima altura posible antes de habilitar el scroll
        contentHeight = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        print(">", [bounds.size, contentView.frame, contentHeight])
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            print(">>>>", bounds.size, contentView.frame)
            self.invalidateIntrinsicContentSize()
        }
    }

    /**/
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: contentView.frame.width, height: contentHeight)
    }
   
   

}
