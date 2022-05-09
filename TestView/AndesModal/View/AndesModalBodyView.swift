//
//  ScrollableStick.swift
//  TestView
//
//  Created by Carlos Ml on 6/05/22.
//  Copyright © 2022 Mercado Libre. All rights reserved.
//

import UIKit

@IBDesignable internal class AndesModalBodyView: UIScrollView {
    
    private(set) var fixedTitleView = AndesModalTitleView()
    private(set) var imageView = AndesModalImageView()
    private(set) var titleView = AndesModalTitleView()
    private(set) var bodyLabel = UILabel()
    
    @IBInspectable var isStickTitleEnabled = true {
        didSet {
            updateLayout()
        }
    }
    
    @IBInspectable var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue}
    }
    
    @IBInspectable var title: String? {
        get { titleView.titleLabel.text }
        set { titleView.titleLabel.text = newValue}
    }
    
    @IBInspectable var body: String? {
        get { bodyLabel.text }
        set { bodyLabel.text = newValue}
    }
    
    @IBInspectable var allowCloseButton: Bool {
        get { !fixedTitleView.closeButton.isHidden }
        set { fixedTitleView.closeButton.isHidden = !newValue}
    }
    
    var textAlignment: NSTextAlignment! {
        didSet {
            titleView.titleLabel.textAlignment = textAlignment
            bodyLabel.textAlignment = textAlignment
        }
    }
    
    internal var distribution: AndesModalVerticalAlignment = .fill
    
    var imageSize: AndesModalImageView.ImageSize {
        get { imageView.size }
        set { imageView.size = newValue}
    }
    
    private var contentHeight: CGFloat = 0.0
    
    deinit {
        print("Eliminado")
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        clipsToBounds = true
        delegate = self
        
        // La ilustracion(full) tiene que llegar hasta el borde
        layoutMargins.top = 0
        layoutMargins.left = 24
        layoutMargins.right = 24
        layoutMargins.bottom = 24
        
        fixedTitleView.layoutMargins.left = layoutMargins.left
        fixedTitleView.layoutMargins.right = layoutMargins.right
        fixedTitleView.backgroundColor = .clear

        imageView.size = .tmb44
        titleView.alignment = .top
        titleView.titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleView.titleLabel.numberOfLines = 0
        bodyLabel.numberOfLines = 0
     
        [imageView, bodyLabel, titleView, fixedTitleView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }
    
    private func updateLayout() {
        // fata verficar el caso con la distribucion en el centro
        fixedTitleView.topAnchor.constraint(equalTo: fixedAnchor).isActive = true

        NSLayoutConstraint.activate([
            fixedTitleView.widthAnchor.constraint(equalTo: widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),

            titleView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            titleView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 26),

            bodyLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 24),
            bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            bodyLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
        ])
    }
    
    private var fixedAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return frameLayoutGuide.topAnchor
        } else {
            guard let superview = superview else {
                preconditionFailure()
            }
            return superview.topAnchor
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        /// Permite que la vista trate de usar la maxima altura posible antes de habilitar el scroll
        contentHeight = contentSize.height + layoutMargins.vertical
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
        
        switch (imageSize, distribution) {
        case (.none, .fill):
            if isStickTitleEnabled {
                titleView.closeButton.isHidden = false
                titleView.closeButton.alpha = 0
                contentInset.top = 0
            } else {
                fixedTitleView.isHidden = true
                titleView.closeButton.alpha = 1
            }
     
        default:
            contentInset.top = fixedTitleView.frame.height
            titleView.closeButton.isHidden = true
            titleView.closeButton.alpha = 1
        }
        
        if case .center = distribution {
            /// El contenido debe tener menor tamanio al del scroll para poderlo centrar verticalemente
            if contentHeight < bounds.size.height  {
                contentInset.top = (bounds.size.height - contentHeight)/2
            }
        }
    }

    /// El contenido tratara de usar el maximo espacio posible antes de comenzar a usar el scroll
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: contentHeight)
    }
}

extension AndesModalBodyView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isStickTitleEnabled {
            let posY = scrollView.contentOffset.y
            let titleY = convert(titleView.frame, to: fixedTitleView).minY
            if  titleY <= fixedTitleView.frame.minY  {
                fixedTitleView.backgroundColor = .white
                fixedTitleView.title = titleView.titleLabel.text
                fixedTitleView.showShadown()
            } else {
                fixedTitleView.backgroundColor = .clear
                fixedTitleView.title = ""
                fixedTitleView.hiddeShadown()
            }
        }
        
    }
    
}
