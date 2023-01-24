//
//  ReviewsCollectionView.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/21/22.
//

import Foundation
import UIKit

final class ParametersCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "Cell"
    
    //MARK: - Views
    private var parameterLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    private var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    public func configureCollectionViewCell(parameter: SettingsModel, value: String) {
        let paramType = parameter.isFirstParameter ? parameter.firstParameter : parameter.secondParameter
        self.parameterLabel.text = "\(parameter.parameterName.description), \(paramType.description)"
        self.valueLabel.text = value
    }
    
    //MARK: - Private methods
    private func setupLayout() {
        contentView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.leading.trailing.equalToSuperview().inset(5)
        }
        
        contentView.addSubview(parameterLabel)
        parameterLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(25)
            make.leading.trailing.equalToSuperview().inset(5)
        }
    }
}


