//
//  AndesModalPageHeaderView.swift
//  AndesUI
//
//  Created by Carlos Chaguendo on 4/05/22.
//

import UIKit

@IBDesignable internal class AndesModalImageView: UIView {
    
    private let imageView = UIImageView()
    
    @IBInspectable var image: UIImage? {
        set { imageView.image = newValue}
        get { imageView.image }
    }
    
    var size: ImageSize = .tmb {
        didSet {
            updateView()
            invalidateIntrinsicContentSize()
        }
    }
    
    init() {
        super.init(frame: .zero)
        setup()
        updateView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        layoutMargins = .zero
        preservesSuperviewLayoutMargins = false
        
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .green
    }
    
    private func updateView() {
        imageView.layer.cornerRadius = 0
        imageView.removeFromSuperview()
        imageView.constraints.forEach(imageView.removeConstraint(_:))
        addSubview(imageView)
        switch size {
        case .tmb:
            imageView.layer.cornerRadius = size.height/2
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
                imageView.widthAnchor.constraint(equalToConstant: size.height),
                imageView.heightAnchor.constraint(equalToConstant: size.height)
            ])
            
        case .banner:
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalToConstant: size.height),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            
        default:
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalToConstant: size.height),
                imageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
                imageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                imageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            ])
        }
    }
    
    override var intrinsicContentSize: CGSize {
        if isHidden {
            return .zero
        }
        let height = layoutMargins.vertical + size.height
        return CGSize(width: super.intrinsicContentSize.width, height: height)
    }
       
}

extension UIEdgeInsets {
    var horizontal: CGFloat { self.left + self.right }
    var vertical: CGFloat { self.top + self.bottom }
}
