//
//  AndesModalStickTitleView.swift
//  AndesUI
//
//  Created by Carlos Ml on 9/05/22.
//  Copyright © 2022 Mercado Libre. All rights reserved.
//

import UIKit

@IBDesignable
internal class AndesModalTitleView: UIView {
    
    let kCloseButtonSize: CGFloat = 40
    let kHeight: CGFloat = 64
    let kCloseIconSize: CGFloat = 24
    
    private let stackView = UIStackView()
    let titleLabel = UILabel()
    let closeButton = UIButton()
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var alignment: UIStackView.Alignment {
        get { stackView.alignment }
        set { stackView.alignment = newValue }
    }
    
    var closeButtonFirstBaseLine: CGFloat { (kHeight - kCloseButtonSize)/2 + (kCloseButtonSize - kCloseIconSize)/2 }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(frame: .zero)
        setup()
    }
    
    private func setup() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = -8
        stackView.preservesSuperviewLayoutMargins = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // closeButton.backgroundColor = .red
        closeButton.setTitle(nil, for: .normal)
        closeButton.setImage(UIImage(named: "close_24"), for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.layer.masksToBounds = true
        
        /// Deberia alinearse por fuera de los margenes
        /// no se puede realizar por medio de constrains porque se salen fuera de los margenes
        closeButton.transform = .init(translationX: kCloseIconSize/2, y: 0)
        
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        
        layoutMargins = .zero
        preservesSuperviewLayoutMargins = false
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        [titleLabel, closeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        closeButton.layoutMargins.right = (24/2)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),

            closeButton.widthAnchor.constraint(equalToConstant: kCloseButtonSize),
            closeButton.heightAnchor.constraint(equalToConstant: kCloseButtonSize),
            //closeButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: 12)
        ])
    }
    
    func showShadown() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 16
        layer.masksToBounds = false
    }
    
    func hiddeShadown() {
        layer.masksToBounds = true
    }
    
    func reserveSpaceOfCloseButton() {
        closeButton.isHidden = false
        closeButton.alpha = 0
    }
    
    func showCloseButton() {
        closeButton.isHidden = false
        closeButton.alpha = 1
    }
    
    func hiddeCloseButton() {
        closeButton.isHidden = true
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height:  titleLabel.intrinsicContentSize.height)
    }
   
}
