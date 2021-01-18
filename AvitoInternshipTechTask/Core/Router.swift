//
//  Wireframe.swift
//  AvitoInternshipTechTask
//
//  Created by Rustam-Deniz Emirali on 17.01.2021.
//

import UIKit

protocol Router: class {
    var navigationController: UINavigationController? { get set }
    func assembleModule() -> UIViewController
    func popToRootModule(animated: Bool)
    func dismissModule(animated: Bool)
    func popModule(animated: Bool)
    func push(viewController: UIViewController, animated: Bool)
    func present(viewController: UIViewController, animated: Bool)
}

extension Router {
    func popToRootModule(animated: Bool) {
        guard let navigationController = navigationController else { return }
        navigationController.popToRootViewController(animated: animated)
    }
    func dismissModule(animated: Bool) {
        guard let navigationController = navigationController else { return }
        navigationController.dismiss(animated: animated, completion: nil)
    }

    func popModule(animated: Bool) {
        guard let navigationController = navigationController else { return }
        navigationController.popViewController(animated: animated)
    }

    func push(viewController: UIViewController, animated: Bool) {
        guard let navigationController = navigationController else { return }
        navigationController.pushViewController(viewController, animated: animated)
    }

    func present(viewController: UIViewController, animated: Bool) {
        guard let navigationController = navigationController else { return }
        navigationController.present(viewController, animated: animated, completion: nil)
    }

}
