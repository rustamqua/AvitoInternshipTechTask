//
//  AdvertisementTitleLabel.swift
//  AvitoInternshipTechTask
//
//  Created by Rustam-Deniz Emirali on 18.01.2021.
//

import UIKit

final class AdvertisementTitleCell: UICollectionViewCell {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with viewModel: AdvertisementTitleCellViewModel) {
        titleLabel.text = viewModel.title
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate(
            [titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
             titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)]
        )
    }
}
