//
//  ScrollableStick.swift
//  TestView
//
//  Created by Carlos Ml on 6/05/22.
//  Copyright © 2022 Mercado Libre. All rights reserved.
//

import UIKit

@IBDesignable class ScrollableStick: UIScrollView {
    
    private(set) var imageView = AndesModalPageImageView()
    private(set) var titleLabel = UILabel()
    private(set) var bodyLabel = UILabel()
    
    @IBInspectable var isStickTitleEnabled = true {
        didSet {
            setupTopConstraintIfNeeded()
        }
    }
    
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
    
    private var topConstraint: NSLayoutConstraint?
    
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
        #if DEBUG
            imageView.backgroundColor = .red
            titleLabel.backgroundColor = .green
            bodyLabel.backgroundColor = .blue
//            bodyLabel.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        #endif
        
        imageView.size = .tmb44
        bodyLabel.numberOfLines = 0
        
        [imageView, bodyLabel, titleLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }
    
    override func didMoveToSuperview() {
        guard let superview = superview else {
            return
        }
        setupTopConstraintIfNeeded()
        
        let c = titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor)
            c.isActive = true
        c.priority = .defaultLow
        
        
        
        bodyLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        [imageView, titleLabel, bodyLabel].forEach { view in
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        }
        
    }
    
    /// Habilita un constraint con el margen superior segun la propiedad `isStickTitleEnabled`
    private func setupTopConstraintIfNeeded() {
        guard let superview = superview, topConstraint == nil else {
            return
        }
        if #available(iOS 11.0, *) {
            topConstraint = titleLabel.topAnchor.constraint(greaterThanOrEqualTo: frameLayoutGuide.topAnchor)
            topConstraint?.isActive = isStickTitleEnabled
        } else {
            topConstraint = titleLabel.topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor)
            topConstraint?.isActive = isStickTitleEnabled
        }
        topConstraint?.priority = .required
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        print("updateConstraints")
        topConstraint?.constant = layoutMargins.top
    }
    
    
    
    private var contentHeight: CGFloat = 0.0
    public var distribution: AndesModalPageAbstractView.Distribution = .center
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        /// Permite que la vista trate de usar la maxima altura posible antes de habilitar el scroll
        contentHeight = contentSize.height
        print(">", [bounds.size, contentHeight])
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            print(">>>>", bounds.size)
            self.invalidateIntrinsicContentSize()
        }
        
        if case .center = distribution {
            /// El contenido debe tener menor tamanio al del scroll para poderlo centrar verticalemente
            if contentHeight < bounds.size.height  {
                contentInset.top = (bounds.size.height - contentHeight)/2
            }
        }
    }

    /**/
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: contentHeight)
    }
}

