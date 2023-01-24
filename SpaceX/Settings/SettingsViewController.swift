//
//  SettingsViewController.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/24/22.
//  
//

import UIKit
import Foundation
import SnapKit

protocol SettingsViewControllerDelegate: AnyObject {
    func didChangeState(measureType: SettingsModel.ParameterType, tag: Int)
}

final class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: SettingsViewControllerDelegate?
    var presenter: ViewToPresenterSettingsProtocol?
    
    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.settingsLabel
        label.textColor = .white
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifire)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        return tableView
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        safeSettings()
    }
    
    //MARK: - Private methods
    private func configureUI() {
        view.addSubview(settingsLabel)
        settingsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.trailing.equalToSuperview().inset(24)
        }
        
        view.addSubview(settingsTableView)
        settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(settingsLabel.snp.bottom).offset(50)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func safeSettings() {
        presenter?.safeSettings()
    }
    
    //MARK: - Objc methods
    @objc func tapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: PresenterToViewSettingsProtocol {
}

//MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.params?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifire, for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        if let model = presenter?.params?.items {
            cell.configureCell(model: model[indexPath.row])
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
}

//MARK: - SettingsCellDelegate
extension SettingsViewController: SettingsCellDelegate {
    
    func didChangeState(measureType: SettingsModel.ParameterType, tag: Int) {
        delegate?.didChangeState(measureType: measureType, tag: tag)
    }
}
