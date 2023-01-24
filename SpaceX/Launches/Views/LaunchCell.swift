//
//  LaunchCell.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/22/22.
//

import Foundation
import UIKit

final class LaunchCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifire = "TableViewCell"
    
    //MARK: - Views
    private lazy var launchView: LaunchView = {
        let view = LaunchView()
        view.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        view.layer.cornerRadius = 24
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
        contentView.addSubview(launchView)
        launchView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(34)
            make.height.equalTo(100)
        }
    }
    
    //MARK: - Configure Methods
    public func configureCell(model: Launches?) {
        launchView.configureLaunchView(model: model)
    }
}



