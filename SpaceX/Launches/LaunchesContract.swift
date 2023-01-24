//
//  LaunchesContract.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/22/22.
//  
//

import Foundation

// MARK: - View Output (Presenter -> View)
protocol PresenterToViewLaunchesProtocol {
    func succes(model: [Launches]?)
    func failure(error: Error)
}

// MARK: - View Input (View -> Presenter)
protocol ViewToPresenterLaunchesProtocol {
    var view: PresenterToViewLaunchesProtocol? { get set }
    var interactor: PresenterToInteractorLaunchesProtocol? { get set }
    var router: PresenterToRouterLaunchesProtocol? { get set }
    func viewDidLoad()
}

// MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorLaunchesProtocol {
    var presenter: InteractorToPresenterLaunchesProtocol? { get set }
    func requestData()
}

// MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterLaunchesProtocol {
    func didFetchSuccess(model: [Launches]?)
    func didFetchFailure(error: Error)
}

// MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterLaunchesProtocol {
}
