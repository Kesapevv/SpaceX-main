//
//  LaunchesViewController.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/22/22.
//  
//

import UIKit

final class LaunchesViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: ViewToPresenterLaunchesProtocol?
    var launches: [Launches]?
    
    private(set) lazy var launchesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.identifire)
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        return tableView
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        view.backgroundColor = .black
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(launchesTableView)
        launchesTableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

//MARK: - PresenterToViewLaunchesProtocol
extension LaunchesViewController: PresenterToViewLaunchesProtocol {
    func succes(model: [Launches]?) {
        launches = model
        launchesTableView.reloadData()
    }
    
    func failure(error: Error) {
        let alertController = UIAlertController(title: "Error!", message: "Check your internet connection", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try again!", style: .default))
        self.present(alertController, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension LaunchesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCell.identifire, for: indexPath) as? LaunchCell else {
            return UITableViewCell()
        }
        cell.configureCell(model: launches?[indexPath.row])
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
}
