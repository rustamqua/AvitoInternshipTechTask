//
//  AdvertisementInteractor.swift
//  AvitoInternshipTechTask
//
//  Created by Rustam-Deniz Emirali on 18.01.2021.
//

import Foundation

protocol AdvertisementInteractorOutput {
    func fetchAdvertisement() -> Advertisement?
}

final class AdvertisementInteractor: AdvertisementInteractorOutput {

    private let decoder = JSONDecoder()
    
    func fetchAdvertisement() -> Advertisement? {
        guard let path = Bundle.main.path(forResource: "result", ofType: "json") else { return nil }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let advertisement = try decoder.decode(Advertisement.self, from: data)
            return advertisement
        } catch {
            debugPrint(error)
            return nil
        }
    }

}
