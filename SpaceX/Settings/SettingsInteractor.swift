//
//  SettingsInteractor.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/24/22.
//  
//

import Foundation

final class SettingsInteractor: PresenterToInteractorSettingsProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterSettingsProtocol?
    var params: ParametersModel?
    var userSettings: UserSettings?
    
    init(params: ParametersModel?, userSefaults: UserSettings?) {
        self.params = params
        self.userSettings = userSefaults
    }
    
    // MARK: - Public methods
    public func safeSettings() {
        guard let settings = params?.items else { return }
        var settingsArray = [Bool]()
        for i in 0...settings.count - 1  {
            settingsArray.append(settings[i].isFirstParameter)
        }
        userSettings?.safeSettings(settings: settingsArray)
    }
}
