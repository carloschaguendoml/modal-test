//
//  AndesModalBodyView.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 11/05/22.
//

import UIKit

@IBDesignable
internal class AndesModalBodyView: UIScrollView {
    private let fixedTitleView = AndesModalTitleView()
    private let imageView = AndesModalImageView()
    private let titleView = AndesModalTitleView()
    private let bodyLabel = UILabel()
    private let footerContainer = UIView()

    private var contentHeight: CGFloat = 0.0
    internal var distribution: AndesModalVerticalAlignment = .top

    @IBInspectable var allowsCloseButton = true
    @IBInspectable var isFixedTitleEnabled = true
    @IBInspectable var isFixedFooterEnabled = true

    @IBInspectable var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

    @IBInspectable var title: String? {
        get { titleView.title }
        set { titleView.title = newValue }
    }

    @IBInspectable var body: String? {
        get { bodyLabel.text }
        set { bodyLabel.text = newValue }
    }

    var textAlignment: NSTextAlignment = .left {
        didSet {
            titleView.textAlignment = textAlignment
            bodyLabel.textAlignment = textAlignment
        }
    }

    var imageStyle: AndesModalImageStyle {
        get { imageView.imageStyle }
        set { imageView.imageStyle = newValue }
    }

    var imageLayoutMargins: UIEdgeInsets {
        get { imageView.layoutMargins }
        set { imageView.layoutMargins = newValue }
    }

    var footerLayoutMargins: UIEdgeInsets {
          get { footerContainer.layoutMargins }
          set { footerContainer.layoutMargins = newValue }
      }

    var footerView: UIView? {
        willSet {
            if newValue == nil { removeFooterView() }
        }
        didSet {
            setupFooterView()
        }
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
        // Default margins, Can be changed externally
        layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 24, right: 24)
        imageLayoutMargins = layoutMargins

        fixedTitleView.preservesSuperviewLayoutMargins = true
        fixedTitleView.backgroundColor = .clear

        titleView.alignment = .top
        titleView.numberOfLines = 0
        bodyLabel.numberOfLines = 0

        footerContainer.backgroundColor = .white

        [imageView, bodyLabel, titleView, fixedTitleView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }

    private func removeFooterView() {
        footerView?.removeFromSuperview()
        updateLayout()
    }

    private func setupFooterView() {
        guard let footerView = footerView else {
            return
        }
        footerView.translatesAutoresizingMaskIntoConstraints = false
        updateLayout()
    }

    internal func updateLayout() {
        [imageView, bodyLabel, titleView, fixedTitleView, footerContainer].compactMap { $0 }.forEach { view in
            view.removeFromSuperview()
            self.addSubview(view)
        }

        setupCloseButton()
        setupHeaderConstratints()

        let titleTopMargin = imageStyle == .none ? fixedTitleView.closeButtonFirstBaseLine : 26
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
            bodyLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 24)
        ])

        setupFooterConstraints()
    }

    private func setupCloseButton() {
        guard allowsCloseButton else {
            // `card`: the close button is always on the outside of the card.
            fixedTitleView.isHidden = !isFixedTitleEnabled
            fixedTitleView.hideCloseButton()
            titleView.hideCloseButton()
            return
        }

        titleView.hideCloseButton()
        if case .none = imageStyle, isFixedTitleEnabled {
            titleView.reserveCloseButtonSpace()
        }

        if case .none = imageStyle, !isFixedTitleEnabled {
            fixedTitleView.isHidden = true
            titleView.showCloseButton()
        }
    }

    private func setupHeaderConstratints() {
        if isFixedTitleEnabled {
            NSLayoutConstraint.activate([
                fixedTitleView.topAnchor.constraint(equalTo: topFixedAnchor),
                imageView.topAnchor.constraint(equalTo: topAnchor)
            ])
            contentInset.top = imageStyle == .none ? 0 : fixedTitleView.kHeight
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

        if isFixedFooterEnabled {
            contentInset.bottom = height + layoutMargins.bottom
            NSLayoutConstraint.activate([
                bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                footerContainer.bottomAnchor.constraint(equalTo: bottomFixedAnchor)
                // footerContainer.heightAnchor.constraint(equalToConstant: height),
            ])
        } else {
            NSLayoutConstraint.activate([
                footerContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
                footerContainer.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: layoutMargins.bottom)
            ])
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        contentHeight = contentSize.height + layoutMargins.vertically
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }

        if case .middle = distribution {
            if contentHeight < bounds.size.height {
                contentInset.top = (bounds.size.height - contentHeight) / 2
            }
        }

        // `Banner` has to reach to the edge
        //  override any value that they set externally
        layoutMargins.top = 0
    }

    override public var intrinsicContentSize: CGSize {
        // The content will try to use as much space as possible before starting to scroll.
        return CGSize(width: contentSize.width, height: contentHeight + contentInset.vertically)
    }
}

extension AndesModalBodyView: UIScrollViewDelegate {
    private func fixedHeaderIfNeeded() {
        guard isFixedTitleEnabled else {
            return
        }

        let posY = contentOffset.y
        if posY + contentInset.top > 1 {
            fixedTitleView.title = ""
            fixedTitleView.showShadow()
        } else {
            fixedTitleView.hideShadow()
        }

        let titleY = convert(titleView.frame, to: fixedTitleView).minY
        if titleY < fixedTitleView.frame.minY {
            fixedTitleView.showTitle(title)
        } else {
            fixedTitleView.hideTitle()
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        fixedHeaderIfNeeded()
    }
}

