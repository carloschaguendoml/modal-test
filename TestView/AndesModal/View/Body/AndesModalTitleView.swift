//
//  AndesModalTitleView.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 11/05/22.
//

import UIKit

internal class AndesModalTitleView: UIView {
    let kHeight: CGFloat = 64
    let kIconSize: CGFloat = 24
    let kButtonSize: CGFloat = 40

    private(set) var isShadowVisible = false
    private(set) var isTitleVisible = false

    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let closeButton = UIButton()

    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    var alignment: UIStackView.Alignment {
        get { stackView.alignment }
        set { stackView.alignment = newValue }
    }

    var textAlignment: NSTextAlignment {
        get { titleLabel.textAlignment }
        set { titleLabel.textAlignment = newValue }
    }

    var numberOfLines: Int {
        get { titleLabel.numberOfLines }
        set { titleLabel.numberOfLines = newValue }
    }

    var closeButtonFirstBaseLine: CGFloat {
        return (kHeight - kButtonSize) / 2 + (kButtonSize - kIconSize) / 2
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

        closeButton.setImage(UIImage(named: "close_24"), for: .normal)
        closeButton.setTitle(nil, for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.transform = .init(translationX: kIconSize / 2, y: 0)

        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)

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
            closeButton.heightAnchor.constraint(equalToConstant: kButtonSize)
        ])
    }

    func reserveCloseButtonSpace() {
        closeButton.isHidden = false
        closeButton.alpha = 0
    }

    func showCloseButton() {
        closeButton.isHidden = false
        closeButton.alpha = 1
    }

    func hideCloseButton() {
        closeButton.isHidden = true
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: titleLabel.intrinsicContentSize.height)
    }

    // MARK: - Animations

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

    func hideTitle() {
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

    func showShadow() {
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

    func hideShadow() {
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
}

