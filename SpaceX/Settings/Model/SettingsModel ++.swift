//
//  SettingsModel ++.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/26/22.
//

import Foundation

extension SettingsModel {
    enum ParameterType: CustomStringConvertible {
        case kg, lb, m, ft
        
        var description: String {
            switch self {
            case .lb:
                return "lb"
            case .kg:
                return "kg"
            case .ft:
                return "ft"
            case .m:
                return "m"
            }
        }
    }
    
    enum ParameterName: CustomStringConvertible {
        case height, diameter, mass, load
        
        var description: String {
            switch self {
            case .height:
                return "Height"
            case .diameter:
                return "Diameter"
            case .mass:
                return "Mass"
            case .load:
                return "Pay load"
            }
        }
    }
}
