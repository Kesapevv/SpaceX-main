//
//  SettingsRouter.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/24/22.
//  
//

import Foundation
import UIKit

final class SettingsRouter: PresenterToRouterSettingsProtocol {
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Static methods
    static func createModule(params: ParametersModel?) -> UIViewController {
        
        let viewController = SettingsViewController()
        let userSettings = UserSettings()
        
        let presenter: ViewToPresenterSettingsProtocol & InteractorToPresenterSettingsProtocol = SettingsPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = SettingsRouter(viewController: viewController)
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SettingsInteractor(params: params, userSefaults: userSettings)
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
}
