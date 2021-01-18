//
//  AdvertisementOptionCollectionViewCell.swift
//  AvitoInternshipTechTask
//
//  Created by Rustam-Deniz Emirali on 18.01.2021.
//

import UIKit

private enum Constants {
    static let titleFontSize: CGFloat = 24
    static let additionalInfoFontSize: CGFloat = 16
    static let priceFontSize: CGFloat = 20
    static let stackViewSpacing: CGFloat = 12
    static let defaultSideInset: CGFloat = 12
    static let selectionIconSize: CGFloat = 24
    static let optionIconSize: CGFloat = 54
    static let defaultTopBottomInset: CGFloat = 16
    static let cellWidth = UIScreen.main.bounds.width - 32
}

final class AdvertisementOptionCell: UICollectionViewCell {
    
    static let textContentWidth = Constants.cellWidth -
        Constants.defaultSideInset * 4 - Constants.selectionIconSize - Constants.optionIconSize
    static let staticContentHeight = Constants.defaultTopBottomInset * 2 + 26 + Constants.stackViewSpacing * 2
    
    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var optionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.titleFontSize)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var additionalInfo: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: Constants.additionalInfoFontSize)
        return label
    }()
    
    private lazy var price: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.priceFontSize)
        return label
    }()
    
    private lazy var selectionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "checkmark")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textContentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [title, additionalInfo, price])
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.spacing = Constants.stackViewSpacing
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func prepareForReuse() {
        optionIcon.image = nil
    }
    
    func configure(with viewModel: AdvertisementOptionCellViewModel) {
        title.text = viewModel.title
        price.text = viewModel.price
        if let info = viewModel.info {
            additionalInfo.text = info
            additionalInfo.isHidden = false
        } else {
            additionalInfo.isHidden = true
        }
        selectionIcon.isHidden = !viewModel.isSelected
    }
    
    func loadIconFromCache(image: UIImage?) {
        optionIcon.image = image
    }
    
    private func setupUI() {
        [background, optionIcon, textContentStackView, selectionIcon].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate(
            [background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             background.topAnchor.constraint(equalTo: contentView.topAnchor),
             background.widthAnchor.constraint(equalTo: contentView.widthAnchor),
             background.heightAnchor.constraint(equalTo: contentView.heightAnchor),
             optionIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.defaultSideInset),
             optionIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.defaultTopBottomInset),
             optionIcon.heightAnchor.constraint(equalToConstant: Constants.optionIconSize),
             optionIcon.widthAnchor.constraint(equalToConstant: Constants.optionIconSize),
             textContentStackView.leadingAnchor.constraint(equalTo: optionIcon.trailingAnchor, constant: Constants.defaultSideInset),
             textContentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.defaultTopBottomInset),
             textContentStackView.trailingAnchor.constraint(equalTo: selectionIcon.leadingAnchor, constant: -Constants.defaultSideInset),
             textContentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.defaultTopBottomInset),
             selectionIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.defaultSideInset),
             selectionIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
             selectionIcon.heightAnchor.constraint(equalToConstant: Constants.selectionIconSize),
             selectionIcon.widthAnchor.constraint(equalToConstant: Constants.selectionIconSize)
            ]
        )
    }
}
