//
//  Advertisement.swift
//  AvitoInternshipTechTask
//
//  Created by Rustam-Deniz Emirali on 17.01.2021.
//

import Foundation

struct Advertisement: Decodable {

    let result: AdvertisementInfo

    struct AdvertisementInfo: Decodable {
        let title: String
        let actionTitle: String
        let selectedActionTitle: String
        let list: [AdvertisementOption]
    }

    struct AdvertisementOption: Decodable {
        let id: String
        let title: String
        let description: String?
        let icon: AdvertisementIconResolution
        let price: String
        let isSelected: Bool
    }

    struct AdvertisementIconResolution: Decodable {
        //swiftlint:disable nesting
        private enum CodingKeys: String, CodingKey {
            case small = "52x52"
        }

        let small: String
    }

}
