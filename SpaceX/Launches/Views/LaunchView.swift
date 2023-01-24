//
//  LaunchView.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/22/22.
//

import Foundation
import UIKit
import SnapKit

final class LaunchView: UIView {
    
    //MARK: - Properties
    private let launcNamelabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 142/255, green: 142/255, blue: 142/255, alpha: 1)
        return label
    }()
    
    private let launchImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurationUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configurationUI()
    }
    
    //MARK: - Private methods
    private func configurationUI() {
        
        addSubview(launcNamelabel)
        launcNamelabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(24)
            make.width.equalTo(220)
        }
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview().inset(24)
        }
        
        addSubview(launchImage)
        launchImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(33)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(30)
        }
    }
    
    //MARK: - Public methods
    public func configureLaunchView(model: Launches?) {
        if let model = model {
            launcNamelabel.text = model.name
            dateLabel.text = model.dateUtc.longDateConverter()
            if let success = model.success {
                launchImage.image = UIImage(named: success ? "rocket" : "rocketFail")
            }
        }
    }
}



