//
//  SettingsModel.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/25/22.
//

import Foundation

final class SettingsModel {
    
    var parameterName: ParameterName
    var firstParameter: ParameterType
    var secondParameter: ParameterType
    var isFirstParameter: Bool
    var tag: Int
    
    init(parameterName: ParameterName, firstParameter: ParameterType, secondParameter: ParameterType, isLeftState: Bool, tag: Int) {
        self.parameterName = parameterName
        self.firstParameter = firstParameter
        self.secondParameter = secondParameter
        self.isFirstParameter = isLeftState
        self.tag = tag
    }
}


class ParametersModel {
        
    var items: [SettingsModel] = [SettingsModel(parameterName: .height, firstParameter: .m, secondParameter: .ft, isLeftState: true, tag: 0),
                                  SettingsModel(parameterName: .diameter, firstParameter: .m, secondParameter: .ft, isLeftState: true, tag: 1),
                                  SettingsModel(parameterName: .mass, firstParameter: .kg, secondParameter: .lb, isLeftState: true, tag: 2),
                                  SettingsModel(parameterName: .load, firstParameter: .kg, secondParameter: .lb, isLeftState: true, tag: 3)]
}

