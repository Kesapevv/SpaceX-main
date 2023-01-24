//
//  RocketsContract.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/21/22.
//  
//

import Foundation


// MARK: - View Output (Presenter -> View)
protocol PresenterToViewRocketsProtocol {
    func succes(model: [Rocket]?, params: ParametersModel?)
    func failure(error: Error)
}

// MARK: - View Input (View -> Presenter)
protocol ViewToPresenterRocketsProtocol {
    
    var view: PresenterToViewRocketsProtocol? { get set }
    var interactor: PresenterToInteractorRocketsProtocol? { get set }
    var router: PresenterToRouterRocketsProtocol? { get set }
    
    func viewDidLoad()
    func didTapLaunchButton(rocketID: String, rocketName: String)
    func getRocketModel() -> [Rocket]?
    func getParamsModel() -> ParametersModel?
}

// MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorRocketsProtocol {
    var presenter: InteractorToPresenterRocketsProtocol? { get set }
    var rocketModel: [Rocket]? { get set }
    var paramModel: ParametersModel? { get set }

    func requestData()
}

// MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterRocketsProtocol {
    func didFetchSuccess(model: [Rocket]?)
    func didFetchFailure(error: Error)
}

// MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterRocketsProtocol {
    func showLaunchScreen(rocketID: String, rocketName: String)
}
