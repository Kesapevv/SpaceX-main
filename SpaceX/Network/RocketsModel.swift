//
//  RocketsModel.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/21/22.
//

import Foundation

// MARK: - Rocket
struct Rocket: Codable {
    let height, diameter: DistanceMeasure
    let mass: MassMeasure
    let firstStage: FirstStage
    let secondStage: SecondStage
    let payloadWeights: [PayloadWeight]
    let flickrImages: [String]
    let name: String
    let stages, costPerLaunch: Int
    let firstFlight, country, company: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case height, diameter, mass
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case payloadWeights = "payload_weights"
        case flickrImages = "flickr_images"
        case name, stages
        case costPerLaunch = "cost_per_launch"
        case firstFlight = "first_flight"
        case country, company
        case id
    }
}

// MARK: - Diameter
struct DistanceMeasure: Codable {
    let meters, feet: Double?
}

// MARK: - Thrust
struct Thrust: Codable {
    let kN, lbf: Int
}

// MARK: - FirstStage
struct FirstStage: Codable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?

    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}

// MARK: - Mass
struct MassMeasure: Codable {
    let kg, lb: Int
}

// MARK: - PayloadWeight
struct PayloadWeight: Codable {
    let kg, lb: Int
}

// MARK: - SecondStage
struct SecondStage: Codable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?

    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}

typealias Rockets = [Rocket]
