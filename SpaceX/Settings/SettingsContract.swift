//
//  SettingsContract.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/24/22.
//  
//

import Foundation


// MARK: - View Output (Presenter -> View)
protocol PresenterToViewSettingsProtocol {
}

// MARK: - View Input (View -> Presenter)
protocol ViewToPresenterSettingsProtocol {
    
    var view: PresenterToViewSettingsProtocol? { get set }
    var interactor: PresenterToInteractorSettingsProtocol? { get set }
    var router: PresenterToRouterSettingsProtocol? { get set }
    var params: ParametersModel? { get }
    
    func safeSettings()
}

// MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSettingsProtocol {
    var params: ParametersModel? { get set }
    var presenter: InteractorToPresenterSettingsProtocol? { get set }
    
    func safeSettings()
}

// MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSettingsProtocol {
}

// MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterSettingsProtocol {
}
