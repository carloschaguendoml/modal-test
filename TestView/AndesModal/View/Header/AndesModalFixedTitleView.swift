//
//  AndesModalStickTitleView.swift
//  AndesUI
//
//  Created by Carlos Ml on 9/05/22.
//  Copyright © 2022 Mercado Libre. All rights reserved.
//

import UIKit

@IBDesignable internal class AndesModalTitleView: UIView {
    
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
        stackView.spacing = 8
        stackView.preservesSuperviewLayoutMargins = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.backgroundColor = tintColor.withAlphaComponent(0.2)
        closeButton.layer.masksToBounds = true
        
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        
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

            closeButton.widthAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    func showShadown() {
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.2
        layer.masksToBounds = false
    }
    
    func hiddeShadown() {
        layer.masksToBounds = true
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height:  isHidden ? 0 : 64)
    }
   
}
