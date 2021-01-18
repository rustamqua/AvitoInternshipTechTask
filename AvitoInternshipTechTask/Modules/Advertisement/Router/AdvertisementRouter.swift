//
//  AdvertisementRouter.swift
//  AvitoInternshipTechTask
//
//  Created by Rustam-Deniz Emirali on 17.01.2021.
//

import UIKit

protocol AdvertisementRoutable: Router {
    func presentAdvertisementDetails(with viewModel: AdvertisementOptionCellViewModel?, errorMessage: String)
}

final class AdvertisementRouter: AdvertisementRoutable {

    weak var navigationController: UINavigationController?

    func assembleModule() -> UIViewController {
        let presenter = AdvertisementPresenter(interactor: AdvertisementInteractor(), router: self)
        let advertisementVC = AdvertisementViewController(presenter: presenter)
        let navigationController = UINavigationController(rootViewController: advertisementVC)
        self.navigationController = navigationController
        return navigationController
    }

    func presentAdvertisementDetails(with viewModel: AdvertisementOptionCellViewModel?, errorMessage: String) {
        var alert: UIAlertController
        if let viewModel = viewModel {
            alert = UIAlertController(title: viewModel.title, message: viewModel.info, preferredStyle: .alert)
        } else {
            alert = UIAlertController(title: errorMessage, message: nil, preferredStyle: .alert)
        }
        alert.addAction(.init(title: "OK", style: .default, handler: nil))
        present(viewController: alert, animated: true)
    }
    
}
