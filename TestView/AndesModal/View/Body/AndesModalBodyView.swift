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
        didSet { updateLayout() }
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
    
    @IBInspectable var allowCloseButton: Bool = true {
        didSet { updateCloseButton() }
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
    
    var imageLayoutMargins: UIEdgeInsets {
        get { imageView.layoutMargins }
        set { imageView.layoutMargins = newValue}
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
        
        /// Margenes por defecto podria sobreescribirse externamente
        layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 24, right: 24)
        imageLayoutMargins = layoutMargins
        
        fixedTitleView.preservesSuperviewLayoutMargins = true
        fixedTitleView.backgroundColor = .clear

        titleView.alignment = .top
        titleView.titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleView.titleLabel.numberOfLines = 0
        bodyLabel.numberOfLines = 0
     
        [imageView, bodyLabel, titleView, fixedTitleView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }
    
    private func updateCloseButton() {
        guard allowCloseButton else {
            // en modo card, el boton de cerrar siempre esta por fuera
            fixedTitleView.isHidden = !isStickTitleEnabled
            titleView.hiddeCloseButton()
            return
        }
        
        titleView.hiddeCloseButton()
        if case .none = imageSize, isStickTitleEnabled {
            titleView.reserveSpaceOfCloseButton()
        }
        
        if case .none = imageSize, !isStickTitleEnabled {
            fixedTitleView.isHidden = true
            titleView.showCloseButton()
        }
    }
    
    private func updateLayout() {
        updateCloseButton()
 
        if isStickTitleEnabled {
            // fata verficar el caso con la distribucion en el centro
            NSLayoutConstraint.activate([
                fixedTitleView.topAnchor.constraint(equalTo: topFixedAnchor),
                imageView.topAnchor.constraint(equalTo: topAnchor)
            ])
            contentInset.top = imageSize == .none ? 0 : 64
        } else {
            NSLayoutConstraint.activate([
                fixedTitleView.topAnchor.constraint(equalTo: topAnchor),
                imageView.topAnchor.constraint(equalTo: fixedTitleView.bottomAnchor)
            ])
        }
        
        let titleTopMargin = imageSize == .none ? fixedTitleView.closeButtonFirstBaseLine : 26
        
        NSLayoutConstraint.activate([
            fixedTitleView.heightAnchor.constraint(equalToConstant: fixedTitleView.kHeight),
            fixedTitleView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),

            titleView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            titleView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: titleTopMargin),

            bodyLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 24),
            bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            bodyLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
        ])
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        /// Permite que la vista trate de usar la maxima altura posible antes de habilitar el scroll
        contentHeight = contentSize.height + layoutMargins.vertical
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
        
        if case .center = distribution {
            /// El contenido debe tener menor tamanio al del scroll para poderlo centrar verticalemente
            if contentHeight < bounds.size.height  {
                contentInset.top = (bounds.size.height - contentHeight)/2
            }
        }
        
        // La ilustracion(full) tiene que llegar hasta el borde
        // sobre escribe culaquier valor que fijen externamente
        layoutMargins.top = 0
    }

    /// El contenido tratara de usar el maximo espacio posible antes de comenzar a usar el scroll
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: contentHeight)
    }
}

extension UIScrollView {
    
     fileprivate var topFixedAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return frameLayoutGuide.topAnchor
        } else {
            guard let superview = superview else {
                preconditionFailure()
            }
            return superview.topAnchor
        }
    }
    
}

extension AndesModalBodyView: UIScrollViewDelegate {
    
    private func fixHeaderIfNeeded() {
        guard isStickTitleEnabled else {
            return
        }
        
        let posY = contentOffset.y
        print("posY", posY +  contentInset.top)
        if posY + contentInset.top > 1 {
            fixedTitleView.backgroundColor = .white
            fixedTitleView.title = nil
            fixedTitleView.showShadown()
        } else {
            fixedTitleView.backgroundColor = .clear
            fixedTitleView.hiddeShadown()
        }
        
        let titleY = convert(titleView.frame, to: fixedTitleView).minY
        if  titleY <= fixedTitleView.frame.minY  {
            //fixedTitleView.backgroundColor = .white
            fixedTitleView.title = title
//
        } else {
            //fixedTitleView.backgroundColor = .clear
            fixedTitleView.title = ""
//
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        fixHeaderIfNeeded()
    }
    
}
