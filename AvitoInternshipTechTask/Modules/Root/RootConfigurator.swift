//
//  RootRouter.swift
//  AvitoInternshipTechTask
//
//  Created by Rustam-Deniz Emirali on 17.01.2021.
//

import UIKit

final class RootConfigurator {

    func setRootViewController(inside window: UIWindow?) {
        window?.makeKeyAndVisible()
        let advertisementRouter = AdvertisementRouter()
        window?.rootViewController = advertisementRouter.assembleModule()
    }
    
}
