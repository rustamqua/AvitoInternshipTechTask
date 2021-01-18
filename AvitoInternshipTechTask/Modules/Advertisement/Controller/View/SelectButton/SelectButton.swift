//
//  SelectButton.swift
//  AvitoInternshipTechTask
//
//  Created by Rustam-Deniz Emirali on 18.01.2021.
//

import UIKit

final class SelectButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.27, green: 0.67, blue: 1.00, alpha: 1.00)
        layer.cornerRadius = 8
        clipsToBounds = true
        titleLabel?.textColor = .white
    }

    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with viewModel: SelectButtonViewModel) {
        setTitle(viewModel.title , for: .normal)
    }
    
}
