//
//  AdvertisementOptionCellViewModel.swift
//  AvitoInternshipTechTask
//
//  Created by Rustam-Deniz Emirali on 18.01.2021.
//

import Foundation

struct AdvertisementOptionCellViewModel {
    let id: String
    let title: String
    let info: String?
    let price: String
    var isSelected: Bool
    var iconUrl: String
    
    init(id: String, title: String, info: String?, price: String, isSelected: Bool, iconUrl: String) {
        self.id = id
        self.title = title
        self.info = info
        self.price = price
        self.isSelected = isSelected
        self.iconUrl = iconUrl
    }
    
    init(prevModel: AdvertisementOptionCellViewModel, isSelected: Bool) {
        self.id = prevModel.id
        self.title = prevModel.title
        self.info = prevModel.info
        self.price = prevModel.price
        self.isSelected = isSelected
        self.iconUrl = prevModel.iconUrl
    }
}
