//
//  
//  AndesModal.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 4/05/22.
//
//

import UIKit

@objc public class AndesModal: NSObject {
    
    internal var contentView:  AndesModalView!
    
    @objc public var hierarchy: AndesModalType = .card

    @objc public var isFixedTitleEnabled: Bool
    
    @objc public var isFixedFooterEnabled: Bool
    
    @objc public var allowsCloseButton = true
    
    internal var imageStyle: AndesModalImageStyle

    internal var pages: [AndesModalPage] = []

    public convenience init(type: AndesModalType, pages: AndesModalPage...) {
        self.init(type: type, pages: pages)
    }
    
    internal init(type: AndesModalType,
                  imageStyle: AndesModalImageStyle = .ilustration160,
                  isFixedTitleEnabled: Bool = true,
                  isFixedFooterEnabled: Bool = true,
                  allowsCloseButton: Bool = true,
                  pages: [AndesModalPage]) {
        self.isFixedTitleEnabled = isFixedTitleEnabled
        self.isFixedFooterEnabled = isFixedFooterEnabled
        self.imageStyle = imageStyle
        self.allowsCloseButton = allowsCloseButton
        self.pages = pages
        super.init()
        self.hierarchy = type
    }

    private func setup() {
        let view = provideView()
        view.delegate = self
        drawContentView(with: view)
    }

    private func drawContentView(with newView: AndesModalView) {
        self.contentView = newView
    }

    private func updateContentView() {
        let config = AndesModalViewConfigFactory.provideInternalConfig(for: self)
        contentView.update(withConfig: config)
    }

    private func provideView() -> AndesModalView {
        let config = AndesModalViewConfigFactory.provideInternalConfig(for: self)
        switch hierarchy {
            case.fullscreen:
            return AndesModalFullView(withConfig: config)
        case .card:
            return AndesModalCardView(withConfig: config)
        }
      
    }
    
    /// show the modal in the view
    /// - Parameters:
    @objc public func show(in vc: UIViewController) {
        setup()
        vc.parent?.view.addSubview(contentView)
        contentView.autoPinEdgesToSuperviewEdges()
    }
}

extension AndesModal: AndesModalViewDelegate {

    func andesModalViewDidDissmis(_ view: AndesModalView) {
        contentView.removeFromSuperview()
    }

}
