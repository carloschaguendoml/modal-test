//
//  AndesModalPageHeaderView.swift
//  TestView
//
//  Created by Carlos Chaguendo on 4/05/22.
//

import UIKit

@IBDesignable internal class AndesModalPageImageView: UIView {
    
    private let imageView = UIImageView()
    
    @IBInspectable var image: UIImage? {
        set { imageView.image = newValue}
        get { imageView.image }
    }
    
    var size: ImageSize = .tmb44 {
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
        print("Coder init")
    }
    
    private func setup() {
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
    }
    
    private func updateView() {
        print("update view")
        imageView.removeFromSuperview()
        imageView.constraints.forEach(imageView.removeConstraint(_:))
        addSubview(imageView)

        switch size {
        case .tmb44:
            imageView.layer.cornerRadius = 44/2
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: size.height),
                imageView.heightAnchor.constraint(equalToConstant: size.height)
            ])
            
        default:
            imageView.layer.cornerRadius = 0
            let margins = size.margins
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor, constant: margins.top),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margins.right),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margins.left),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margins.bottom)
            ])
        }
    }
    
    override var intrinsicContentSize: CGSize {
        if isHidden {
            return .zero
        }
        let height = size.margins.vertical + size.height
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
       
}

extension AndesModalPageImageView {
    
    @available(*, unavailable, message: "support only to interfaz builder")
    @IBInspectable var ibMode: String {
        set {
            print("Set ib mode", newValue)
            guard let mode = ImageSize(rawValue: newValue) else {
                fatalError()
            }
            print("Set ib 2", newValue)
            self.size = mode
        }
        get {
            self.size.rawValue
        }
    }
    
}

fileprivate extension UIEdgeInsets {
    
    var horizontal: CGFloat { self.left + self.right }
    var vertical: CGFloat { self.top + self.bottom }

}
