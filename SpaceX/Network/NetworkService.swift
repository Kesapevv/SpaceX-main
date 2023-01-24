//
//  NetworkService.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/21/22.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func requestRockets(completion: @escaping (Result<Rockets?, Error>) -> ())
    func requestLaunches(completion: @escaping (Result<LaunchesArray?, Error>) -> ())
}

final class NetworkService: NetworkServiceProtocol {
    
    func requestRockets(completion: @escaping (Result<Rockets?, Error>) -> ()) {
        let url = Constants.rocketAPI
        AF.request(url, method: .get).validate().responseDecodable(of: Rockets.self) { response in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
    
    func requestLaunches(completion: @escaping (Result<LaunchesArray?, Error>) -> ()) {
        let url = Constants.launchAPI
        AF.request(url, method: .get).validate().responseDecodable(of: LaunchesArray?.self) { response in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
}
