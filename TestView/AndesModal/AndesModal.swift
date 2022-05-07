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
    
    @objc public var hierarchy: AndesModalHierarchy = .card {
        didSet {
            updateContentView()
        }
    }
    
    @objc public var stickHeader: Bool {
        didSet {
            updateContentView()
        }
    }
    
    @objc public var stickFooter: Bool {
        didSet {
            updateContentView()
        }
    }
    
    internal var imageSize: AndesModalPageImageView.ImageSize {
        didSet {
            updateContentView()
        }
    }
    
    internal var verticalAlignmet: AndesModalPageAbstractView.Distribution  {
        didSet {
            updateContentView()
        }
    }
    
    var accessibilityManager: AndesModalAccessibilityManager?
    
    override public func accessibilityActivate() -> Bool {
        return accessibilityManager?.accessibilityActivated() != nil
    }

    @available(*, unavailable, message: "not suppoted with Interfaz builder")
    required init?(coder: NSCoder) {
        preconditionFailure()
    }

    public convenience init(type: AndesModalHierarchy, pages: AndesModalPage...) {
        self.init(type: type, pages: pages)
    }
    
    internal init(type: AndesModalHierarchy,
                      imageSize: AndesModalPageImageView.ImageSize = .ilustration160,
                      stickHeader: Bool = true,
                      stickFooter: Bool = true,
                      vertical: AndesModalPageAbstractView.Distribution = .fill,
                      pages: [AndesModalPage]) {
        self.stickFooter = stickFooter
        self.stickHeader = stickHeader
        self.imageSize = imageSize
        self.verticalAlignmet = vertical
        super.init()
        self.hierarchy = type
        setup()
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
            return AndesModalViewDefault(withConfig: config)
        }
      
    }
    
    /// show the modal in the view
    /// - Parameters:
    @objc public func show(in vc: UIViewController) {
        
        vc.parent?.view.addSubview(contentView)
        contentView.autoPinEdgesToSuperviewEdges()
    }
}

extension AndesModal: AndesModalViewDelegate {

    func andesModalViewDidDissmis(_ view: AndesModalView) {
        contentView.removeFromSuperview()
    }

}
