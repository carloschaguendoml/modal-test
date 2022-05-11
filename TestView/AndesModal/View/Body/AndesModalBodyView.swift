//
//  ScrollableStick.swift
//  AndesUI
//
//  Created by Carlos Chaguendo on 6/05/22.
//  Copyright © 2022 Mercado Libre. All rights reserved.
//

import UIKit

@IBDesignable
internal class AndesModalBodyView: UIScrollView {
    
    let fixedTitleView = AndesModalTitleView()
    let imageView = AndesModalImageView()
    let titleView = AndesModalTitleView()
    let bodyLabel = UILabel()
    let footerContainer = UIView()
    
    @IBInspectable var isStickTitleEnabled = true
    @IBInspectable var isStickFooterEnabled = true
    
    @IBInspectable var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue}
    }
    
    @IBInspectable var title: String? {
        get { titleView.title }
        set { titleView.title = newValue}
    }
    
    @IBInspectable var body: String? {
        get { bodyLabel.text }
        set { bodyLabel.text = newValue}
    }
    
    @IBInspectable var allowCloseButton: Bool = true
    
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
    
    var footerLayoutMargins: UIEdgeInsets {
        get { footerContainer.layoutMargins }
        set { footerContainer.layoutMargins = newValue}
    }
    
    internal var footerView: UIView? {
        willSet {
            if newValue == nil {
                removeFooterView()
            }
        }
        didSet {
            setupFooterView()
        }
    }
    
    private var contentHeight: CGFloat = 0.0
    
    deinit {
        print("Eliminado body")
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
        /// Margenes por defecto podria fijarse externamente
        layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 24, right: 24)
        imageLayoutMargins = layoutMargins
        
        fixedTitleView.preservesSuperviewLayoutMargins = true
        fixedTitleView.backgroundColor = .clear

        titleView.alignment = .top
        titleView.titleLabel.numberOfLines = 0
        bodyLabel.numberOfLines = 0
        bodyLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        footerContainer.backgroundColor = .white
     
        [imageView, bodyLabel, titleView, fixedTitleView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }
    
    private func removeFooterView() {
        print("Eliminando footer")
        footerView?.removeFromSuperview()
        updateLayout()
    }
    
    private func setupFooterView() {
        guard let footerView = footerView else {
            return
        }
        footerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(footerView)
        updateLayout()
    }
    
    func updateLayout() {
        [imageView, bodyLabel, titleView, fixedTitleView, footerContainer].compactMap { $0 }.forEach { view in
            view.removeFromSuperview()
            self.addSubview(view)
        }
        
        setupCloseButton()
        setupHeaderConstratints()
        
        let titleTopMargin = imageSize == .none ? fixedTitleView.closeButtonFirstBaseLine : 26
        
        NSLayoutConstraint.activate([
            fixedTitleView.heightAnchor.constraint(equalToConstant: fixedTitleView.kHeight),
            fixedTitleView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),

            titleView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            titleView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: titleTopMargin),

            bodyLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            bodyLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
            bodyLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 24),
        ])
        
        setupFooterConstraints()
    }
    
    private func setupCloseButton() {
        guard allowCloseButton else {
            // en modo card, el boton de cerrar siempre esta por fuera
            fixedTitleView.isHidden = !isStickTitleEnabled
            fixedTitleView.hiddeCloseButton()
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
    
    private func setupHeaderConstratints() {
        if isStickTitleEnabled {
            // fata verficar el caso con la distribucion en el centro
            NSLayoutConstraint.activate([
                fixedTitleView.topAnchor.constraint(equalTo: topFixedAnchor),
                imageView.topAnchor.constraint(equalTo: topAnchor)
            ])
            contentInset.top = imageSize == .none ? 0 : fixedTitleView.kHeight
        } else {
            NSLayoutConstraint.activate([
                fixedTitleView.topAnchor.constraint(equalTo: topAnchor),
                imageView.topAnchor.constraint(equalTo: fixedTitleView.bottomAnchor)
            ])
        }
    }
    
    private func setupFooterConstraints() {
        guard let footer = footerView else {
            bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            return
        }
        
       
        footerContainer.translatesAutoresizingMaskIntoConstraints = false
        footerContainer.addSubview(footer)
        
    
        let height = footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        footerContainer.bringSubviewToFront(bodyLabel)
        
        NSLayoutConstraint.activate([
            footer.leadingAnchor.constraint(equalTo: footerContainer.layoutMarginsGuide.leadingAnchor),
            footer.trailingAnchor.constraint(equalTo: footerContainer.layoutMarginsGuide.trailingAnchor),
            footer.topAnchor.constraint(equalTo: footerContainer.layoutMarginsGuide.topAnchor),
            footer.bottomAnchor.constraint(equalTo: footerContainer.layoutMarginsGuide.bottomAnchor),

            footerContainer.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            footerContainer.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            footerContainer.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor)
        ])
        
        if isStickFooterEnabled {
            contentInset.bottom = height + layoutMargins.bottom
            NSLayoutConstraint.activate([
                bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                footerContainer.bottomAnchor.constraint(equalTo: bottomFixedAnchor),
                //footerContainer.heightAnchor.constraint(equalToConstant: height),
            ])
        } else {
            NSLayoutConstraint.activate([
                footerContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
                footerContainer.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: layoutMargins.bottom),
            ])
        }
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
        return CGSize(width: contentSize.width, height: contentHeight + contentInset.vertical)
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
    
    fileprivate var bottomFixedAnchor: NSLayoutYAxisAnchor {
       if #available(iOS 11.0, *) {
           return frameLayoutGuide.bottomAnchor
       } else {
           guard let superview = superview else {
               preconditionFailure()
           }
           return superview.bottomAnchor
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
            fixedTitleView.title = ""
            fixedTitleView.showShadown()
        } else {
            fixedTitleView.hiddeShadown()
        }
        
        let titleY = convert(titleView.frame, to: fixedTitleView).minY
        if titleY < fixedTitleView.frame.minY  {
            fixedTitleView.showTitle(title)
        } else {
            fixedTitleView.hiddeTitle()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        fixHeaderIfNeeded()
    }
    
}
