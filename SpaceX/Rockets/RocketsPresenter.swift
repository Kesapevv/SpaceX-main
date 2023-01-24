//
//  RocketsPresenter.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/21/22.
//  
//

import Foundation

final class RocketsPresenter: ViewToPresenterRocketsProtocol {

    // MARK: - Properties
    var view: PresenterToViewRocketsProtocol?
    var interactor: PresenterToInteractorRocketsProtocol?
    var router: PresenterToRouterRocketsProtocol?
    
    func viewDidLoad() {
        interactor?.requestData()
    }
    
    func didTapLaunchButton(rocketID: String, rocketName: String) {
        router?.showLaunchScreen(rocketID: rocketID, rocketName: rocketName)
    }
    
    func getRocketModel() -> [Rocket]? {
        return interactor?.rocketModel
    }
    
    func getParamsModel() -> ParametersModel? {
        return interactor?.paramModel
    }
}

//MARK: - InteractorToPresenterCardsCollectionProtocol
extension RocketsPresenter: InteractorToPresenterRocketsProtocol {

    func didFetchSuccess(model: [Rocket]?) {
        view?.succes(model: model, params: interactor?.paramModel)
    }
    
    func didFetchFailure(error: Error) {
        view?.failure(error: error)
    }
    
    
}
