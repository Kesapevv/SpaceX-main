//
//  LaunchesRouter.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/22/22.
//  
//

import Foundation
import UIKit

final class LaunchesRouter: PresenterToRouterLaunchesProtocol {
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Static methods
    static func createModule(rocketID: String, rocketName: String) -> UIViewController {
        
        let viewController = LaunchesViewController()
        viewController.title = rocketName
        let networkService = NetworkService()
        let presenter: ViewToPresenterLaunchesProtocol & InteractorToPresenterLaunchesProtocol = LaunchesPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = LaunchesRouter(viewController: viewController)
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = LaunchesInteractor(rocketID: rocketID, networkService: networkService)
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
}
