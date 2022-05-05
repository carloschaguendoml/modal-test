//
//  AndesModalPageHeaderView.swift
//  TestView
//
//  Created by Carlos Chaguendo on 4/05/22.
//

import UIKit

@IBDesignable
internal class AndesModalPageHeaderView: UIView {
    
    private let imageView = UIImageView()
    
    @IBInspectable var image: UIImage? {
        set { imageView.image = newValue}
        get { imageView.image }
    }
    
    var mode: ContentMode = .full {
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .green
    }
    
    private func updateView() {
        print("update view")
        imageView.removeFromSuperview()
        imageView.constraints.forEach(imageView.removeConstraint(_:))
        
        switch mode {
        case .hidden:
            backgroundColor = .red
        case .full:
            backgroundColor = .yellow
            addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        case .tmb:
            backgroundColor = .gray
            addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 50),
                imageView.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
    
    override var intrinsicContentSize: CGSize {
        switch mode {
        case .hidden:
            return CGSize(width: UIView.noIntrinsicMetric, height: 0)
        case .full:
            return CGSize(width: UIView.noIntrinsicMetric, height: 320)
        case .tmb:
            return CGSize(width: UIView.noIntrinsicMetric, height: 600)
        }
    }
       
}

extension AndesModalPageHeaderView {
    
    enum ContentMode: String {
        case hidden
        case full
        case tmb
    }
    
}

extension AndesModalPageHeaderView {
    
    @available(unavailable, message: "support only to interfaz builder")
    @IBInspectable var ibMode: String {
        set {
            print("Set ib mode", newValue)
            guard let mode = ContentMode(rawValue: newValue) else {
                fatalError()
            }
            print("Set ib 2", newValue)
            self.mode = mode
        }
        get {
            self.mode.rawValue
        }
    }
    
}
