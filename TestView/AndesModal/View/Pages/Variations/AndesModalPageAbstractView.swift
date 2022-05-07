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
    public var distribution: Distribution = .fill
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        /// Permite que la vista trate de usar la maxima altura posible antes de habilitar el scroll
        contentHeight = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        print(">", [bounds.size, contentView.frame, contentHeight])
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            print(">>>>", bounds.size, contentView.frame)
            self.invalidateIntrinsicContentSize()
        }
        
        if case .center = distribution {
            /// El contenido debe tener menor tamanio al del scroll para poderlo centrar verticalemente
            if contentHeight < bounds.size.height  {
                scrollView.contentInset.top = (bounds.size.height - contentHeight)/2
            }
        }
    }

    /**/
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: contentView.frame.width, height: contentHeight)
    }
}

extension AndesModalPageAbstractView {
    
    enum Distribution: Int {
        // Trata de ocupar el mayor area disponible
        case fill
        // centra el contenido verticalemnte segun el area disponible
        case center
    }
    
}
