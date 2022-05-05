//
//  UIViewXIB.swift
//  TestView
//
//  Created by Carlos Ml on 5/05/22.
//

import UIKit


@IBDesignable internal class UIViewXIB: UIView {
    
    internal var componentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    /// Por defecto intenta cargar un .xib que coincida con el nombre de la clase
    internal func loadNib() {
        let type = type(of: self)
        let bundle = Bundle(for: type)
        let name = String(describing: type)
        let nib =  UINib(nibName: name, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self).first as? UIView else {
            fatalError()
        }
        componentView = view
    }
    
    internal func pinXibViewToSelf() {
        addSubview(componentView)
        componentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            componentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            componentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            componentView.topAnchor.constraint(equalTo: topAnchor),
            componentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    internal func xibSetup() {
        loadNib()
        pinXibViewToSelf()
    }
    
    
    
}
