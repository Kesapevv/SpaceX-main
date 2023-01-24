//
//  SettingsView.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/24/22.
//
//

import Foundation
import UIKit
import SnapKit

protocol SettingsViewDelegate: AnyObject  {
    func didChangeState(measureType: SettingsModel.ParameterType, tag: Int)
}

final class SettingsView: UIView {
    
    //MARK: - Properties
    weak var delegate: SettingsViewDelegate?
    
    private var parameterTag: Int = 0
    private var leftType: SettingsModel.ParameterType = .m
    private var rightType: SettingsModel.ParameterType = .m
    private var model: SettingsModel?
    
    private var isPickedLeft: Bool = true {
        didSet {
            if isPickedLeft {
                leftOptionView.backgroundColor = .white
                rightOptionView.backgroundColor = .clear
                leftOptionLabel.textColor = .black
            } else {
                leftOptionView.backgroundColor = .clear
                rightOptionView.backgroundColor = .white
                rightOptionLabel.textColor = .black
            }
        }
    }
    
    private let settingslabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let wholeOptionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1)
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let leftOptionView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let rightOptionView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let leftOptionLabel = UILabel()
    private let rightOptionLabel = UILabel()
    
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
        
        addSubview(settingslabel)
        settingslabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(28)
            make.centerY.equalToSuperview()
        }
        
        addSubview(wholeOptionView)
        wholeOptionView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(28)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(115)
        }
        
        wholeOptionView.addSubview(leftOptionView)
        leftOptionView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(3)
            make.width.equalTo(56)
        }
        
        leftOptionView.addSubview(leftOptionLabel)
        leftOptionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        wholeOptionView.addSubview(rightOptionView)
        rightOptionView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview().inset(3)
            make.width.equalTo(56)
        }
        
        rightOptionView.addSubview(rightOptionLabel)
        rightOptionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        wholeOptionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapParameter)))
    }
    
    //MARK: - Public methods
    public func configureSettingView(model: SettingsModel) {
        self.model = model
        
        settingslabel.text = model.parameterName.description
        leftOptionLabel.text = model.firstParameter.description
        rightOptionLabel.text = model.secondParameter.description
        
        isPickedLeft = model.isFirstParameter
        parameterTag = model.tag
        leftType = model.firstParameter
        rightType = model.secondParameter
    }
    
    //MARK: - Obj methods
    @objc private func tapParameter() {
        self.model?.isFirstParameter.toggle()
        isPickedLeft.toggle()
        delegate?.didChangeState(measureType: isPickedLeft ? leftType : rightType, tag: parameterTag)
    }
}
