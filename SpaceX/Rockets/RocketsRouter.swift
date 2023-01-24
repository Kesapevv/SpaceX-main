//
//  RocketsRouter.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/21/22.
//  
//

import Foundation
import UIKit

final class RocketsRouter {
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Static methods
    static func createModule(paramModel: ParametersModel) -> UIViewController {
        
        let viewController = RocketsViewController()
        let presenter: ViewToPresenterRocketsProtocol & InteractorToPresenterRocketsProtocol = RocketsPresenter()
        let networkService = NetworkService()
        let paramModel = paramModel
        
        viewController.presenter = presenter
        viewController.presenter?.router = RocketsRouter(viewController: viewController)
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = RocketsInteractor(networkService: networkService, paramModel: paramModel)
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}

//MARK: - PresenterToRouterRocketsProtocol
extension RocketsRouter: PresenterToRouterRocketsProtocol {
    
    func showLaunchScreen(rocketID: String, rocketName: String) {
        let launchVC = LaunchesRouter.createModule(rocketID: rocketID, rocketName: rocketName)
        self.viewController?.navigationController?.pushViewController(launchVC, animated: true)
    }
}
