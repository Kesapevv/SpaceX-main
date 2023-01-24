//
//  LaunchesModel.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/22/22.
//

import Foundation

struct Launches: Codable {
    var success: Bool?
    var dateUtc: String
    var rocket: String
    var name: String
    enum CodingKeys: String, CodingKey {
        case success, rocket, name
        case dateUtc = "date_utc"
    }
}

typealias LaunchesArray = [Launches]
