//
//  AndesModalStickTitleView.swift
//  AndesUI
//
//  Created by Carlos Chaguendo on 9/05/22.
//  Copyright © 2022 Mercado Libre. All rights reserved.
//

import UIKit

@IBDesignable
internal class AndesModalTitleView: UIView {
    
    let kHeight: CGFloat = 64
    let kIconSize: CGFloat = 24
    let kButtonSize: CGFloat = 40
    
    private(set) var isShadowVisible = false
    private(set) var isTitleVisible = false
    
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
    
    var closeButtonFirstBaseLine: CGFloat {
        return (kHeight - kButtonSize)/2 + (kButtonSize - kIconSize)/2
    }
    
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
        
        closeButton.setTitle(nil, for: .normal)
        closeButton.setImage(UIImage(named: "close_24"), for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        /// tiene que alinearse por fuera de los margenes
        /// no se puede realizar por medio de constrains porque puede romper  el layout
        closeButton.transform = .init(translationX: kIconSize/2, y: 0)
        
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 16
        
        layoutMargins = .zero
        preservesSuperviewLayoutMargins = false
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        [titleLabel, closeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: kButtonSize),
            closeButton.heightAnchor.constraint(equalToConstant: kButtonSize),
        ])
    }
    
    func showTitle(_ title: String?) {
        titleLabel.text = title
        guard !isTitleVisible else {
            return
        }
    
        titleLabel.layer.opacity = 0
        UIView.animate(withDuration: 0.1) {
            self.titleLabel.layer.opacity = 1
        }
        isTitleVisible = true
    }
    
    func hiddeTitle() {
        guard isTitleVisible else {
            return
        }
    
        titleLabel.layer.opacity = 1
        UIView.animate(withDuration: 0.1) {
            self.titleLabel.layer.opacity = 0
            
        } completion: { _ in
            self.titleLabel.text = ""
        }
        isTitleVisible = false
    }
    
    func showShadown() {
        if isShadowVisible {
            return
        }
        isShadowVisible = true
        backgroundColor = .clear
        layer.masksToBounds = false
        UIView.animate(withDuration: 0.1) {
            self.backgroundColor = .white
            self.layer.shadowColor = UIColor.black.cgColor
        }
    }
    
    func hiddeShadown() {
        if !isShadowVisible {
            return
        }
        isShadowVisible = false
        UIView.animate(withDuration: 0.1) {
            self.backgroundColor = .clear
            self.layer.shadowColor = UIColor.clear.cgColor
        } completion: { _ in
            self.layer.masksToBounds = true
        }
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
