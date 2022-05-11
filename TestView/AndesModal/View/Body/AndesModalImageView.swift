//
//  AndesModalImageView.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 11/05/22.
//

import UIKit

internal class AndesModalImageView: UIView {
    private let imageView = UIImageView()

    var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

    var imageStyle: AndesModalImageStyle = .tmb {
        didSet {
            updateView()
            invalidateIntrinsicContentSize()
        }
    }

    init() {
        super.init(frame: .zero)
        setup()
        updateView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        layoutMargins = .zero
        preservesSuperviewLayoutMargins = false

        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .green
    }

    private func updateView() {
        imageView.layer.cornerRadius = 0
        imageView.removeFromSuperview()
        imageView.constraints.forEach(imageView.removeConstraint(_:))
        addSubview(imageView)
        switch imageStyle {
        case .tmb:
            imageView.layer.cornerRadius = imageStyle.height / 2
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
                imageView.widthAnchor.constraint(equalToConstant: imageStyle.height),
                imageView.heightAnchor.constraint(equalToConstant: imageStyle.height)
            ])

        case .banner:
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalToConstant: imageStyle.height),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])

        default:
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalToConstant: imageStyle.height),
                imageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
                imageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                imageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            ])
        }
    }

    override var intrinsicContentSize: CGSize {
        if isHidden {
            return .zero
        }

        if case .none = imageStyle {
            return .zero
        }
        let height = layoutMargins.vertically + imageStyle.height
        return CGSize(width: super.intrinsicContentSize.width, height: height)
    }
}

