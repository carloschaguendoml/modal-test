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
    
    @objc public var hierarchy: AndesModalHierarchy = .card

    @objc public var stickHeader: Bool
    
    @objc public var stickFooter: Bool
    
    @objc public var allowsDismissButton = true
    
    internal var imageSize: AndesModalImageView.ImageSize
    
    internal var textAlignmet: NSTextAlignment
    
    internal var verticalAlignmet: AndesModalVerticalAlignment
    
    internal var pages: [AndesModalPage] = []
    
    var accessibilityManager: AndesModalAccessibilityManager?
    
    override public func accessibilityActivate() -> Bool {
        return accessibilityManager?.accessibilityActivated() != nil
    }


    public convenience init(type: AndesModalHierarchy, pages: AndesModalPage...) {
        self.init(type: type, pages: pages)
    }
    
    internal init(type: AndesModalHierarchy,
                  imageSize: AndesModalImageView.ImageSize = .ilustration160,
                  stickHeader: Bool = true,
                  stickFooter: Bool = true,
                  allowsDismissButton: Bool = true,
                  vertical: AndesModalVerticalAlignment = .fill,
                  textAlignmet: NSTextAlignment = .left,
                  pages: [AndesModalPage]) {
        self.stickFooter = stickFooter
        self.stickHeader = stickHeader
        self.imageSize = imageSize
        self.verticalAlignmet = vertical
        self.textAlignmet = textAlignmet
        self.allowsDismissButton = allowsDismissButton
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
        accessibilityManager?.viewUpdated()
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
