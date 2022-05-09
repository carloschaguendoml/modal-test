//
//  AndesModalStickTitleView.swift
//  AndesUI
//
//  Created by Carlos Ml on 9/05/22.
//  Copyright © 2022 Mercado Libre. All rights reserved.
//

import UIKit

@IBDesignable internal class AndesModalStickTitleView: UIStackView {
    
    private let titleLabel = UILabel()
    private let closeButton = UIButton()
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
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
        preservesSuperviewLayoutMargins = true
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        
        [titleLabel, closeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
//            closeButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44)
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
    
    
    
}
