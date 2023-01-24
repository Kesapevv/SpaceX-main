//
//  RocketsInteractor.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/21/22.
//  
//

import Foundation

final class RocketsInteractor: PresenterToInteractorRocketsProtocol {    

    // MARK: - Properties
    var presenter: InteractorToPresenterRocketsProtocol?
    let networkService: NetworkServiceProtocol?
    var rocketModel: [Rocket]?
    var paramModel: ParametersModel?
    
    // MARK: - init
    init(networkService: NetworkServiceProtocol?, paramModel: ParametersModel) {
        self.networkService = networkService
        self.paramModel = paramModel
    }
    
    // MARK: - Public methods
    public func requestData() {
        networkService?.requestRockets { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let rocket):
                self.rocketModel = rocket
                self.presenter?.didFetchSuccess(model: rocket)
            case .failure(let error):
                self.presenter?.didFetchFailure(error: error)
            }
        }
    }
}
