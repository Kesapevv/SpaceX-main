//
//  LaunchesInteractor.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/22/22.
//  
//

import Foundation

final class LaunchesInteractor: PresenterToInteractorLaunchesProtocol {

    // MARK: - Properties
    var presenter: InteractorToPresenterLaunchesProtocol?
    var rocketID: String
    let networkService: NetworkServiceProtocol?
    var launches: LaunchesArray!
    
    init(rocketID: String, networkService: NetworkServiceProtocol?) {
        self.rocketID = rocketID
        self.networkService = networkService
    }
    
    // MARK: - Public methods
    public func requestData() {
        networkService?.requestLaunches { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let launches):
                self.launches = launches
                self.presenter?.didFetchSuccess(model: self.getArraysOfRockets())
            case .failure(let error):
                self.presenter?.didFetchFailure(error: error)
            }
        }
    }
    
    // MARK: - Private methods
    private func getArraysOfRockets() -> [Launches]? {
        var array: [Launches] = []
        
        launches.forEach { item in
            if item.rocket == self.rocketID {
                array.append(item)
            }
        }
        return array
    }
}
