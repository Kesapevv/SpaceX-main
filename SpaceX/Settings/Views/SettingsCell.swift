//
//  SettingsCell.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/24/22.
//

import Foundation
import UIKit

protocol SettingsCellDelegate: AnyObject  {
    func didChangeState(measureType: SettingsModel.ParameterType, tag: Int)
}

final class SettingsCell: UITableViewCell {
    
    //MARK: - Properties
    
    weak var delegate: SettingsCellDelegate?
    
    static let identifire = "TableViewCell"
    
    private lazy var settingsView: SettingsView = {
        let view = SettingsView()
        view.delegate = self
        return view
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - Private Methods
    private func setupLayout() {
        contentView.addSubview(settingsView)
        settingsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(64)
        }
    }
    
    //MARK: - Configure Methods
    public func configureCell(model: SettingsModel) {
        settingsView.configureSettingView(model: model)
    }
}

//MARK: - SettingsViewDelegate
extension SettingsCell: SettingsViewDelegate {
    func didChangeState(measureType: SettingsModel.ParameterType, tag: Int) {
        delegate?.didChangeState(measureType: measureType, tag: tag)
    }
}
