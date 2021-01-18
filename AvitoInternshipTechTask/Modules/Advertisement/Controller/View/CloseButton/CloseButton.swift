//
//  CloseButton.swift
//  AvitoInternshipTechTask
//
//  Created by Rustam-Deniz Emirali on 18.01.2021.
//

import UIKit

final class CloseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: "CloseIconTemplate"), for: .normal)
        tintColor = .black
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
}
