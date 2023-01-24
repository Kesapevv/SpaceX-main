//
//  RocketInfoView.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/22/22.
//

import SnapKit
import UIKit

protocol RocketInfoViewDelegate: AnyObject {
    func didTapSettingsButton()
}

final class RocketInfoView: UIView {
    
    //MARK: - Properties
    weak var delegate: RocketInfoViewDelegate?
    
    var rocketInfoModel = RocketInfoModel()
    var rocketModel: [Rocket]?
    var params: ParametersModel?
    var currentPage: Int = 0
    
    var rocketValues: [String] = []
    
    private let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private let settingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gearshape")
        imageView.tintColor = .white
        return imageView
    }()
    
    private var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private(set) lazy var сharacteristicsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.register(ParametersCell.self, forCellWithReuseIdentifier: ParametersCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(withCollection: Bool) {
        self.init(frame: CGRect.zero)
        commonInit(withCollection: withCollection)
    }
    
    private func commonInit(withCollection: Bool) {
        
        addSubview(rocketNameLabel)
        rocketNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(rocketNameLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        if withCollection {
            addSubview(сharacteristicsCollectionView)
            сharacteristicsCollectionView.snp.makeConstraints { make in
                make.top.equalTo(rocketNameLabel.snp.bottom).offset(32)
                make.leading.equalToSuperview().offset(32)
                make.trailing.equalToSuperview().inset(32)
                make.height.equalTo(100)
            }
            
            contentStackView.snp.remakeConstraints() { make in
                make.top.equalTo(сharacteristicsCollectionView.snp.bottom).offset(40)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
        
    }
    
    //MARK: - configuration methods
    public func configureMainInfo(model: [Rocket]?, curentPage: Int, params: ParametersModel?) {
        self.params = params
        rocketModel = model
        currentPage = curentPage
        contentStackView.subviews.forEach({$0.removeFromSuperview()})
        configureRocketValues(model: model, curentPage: curentPage)
        
        addSubview(settingImage)
        settingImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(35)
            make.height.width.equalTo(35)
        }
        
        if let model = model?[curentPage] {
            rocketNameLabel.text = model.name
            configureTitle(label: rocketInfoModel.firstStart, info: model.firstFlight.shortDateConverter())
            configureTitle(label: rocketInfoModel.country, info: model.country)
            configureTitle(label: rocketInfoModel.price, info: model.costPerLaunch.createCurrencyString())
        }
        
        settingImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapSettingsButton)))
        settingImage.isUserInteractionEnabled = true
    }
    
    public func configureFirstStageInfo(model: [Rocket]?, curentPage: Int) {
        contentStackView.subviews.forEach({$0.removeFromSuperview()})
        if let model = model?[curentPage] {
            rocketNameLabel.text = Constants.firstStage
            configureTitle(label: rocketInfoModel.amountOfEngines, info: String(model.firstStage.engines))
            configureTitle(label: rocketInfoModel.amountOfFuel, info: String(model.firstStage.fuelAmountTons) + Constants.weightMeasure)
            if let burnTimeSEC = model.firstStage.burnTimeSEC {
                configureTitle(label: rocketInfoModel.timeOfBurn, info: String(burnTimeSEC) + Constants.timeMeasure)
            }
        }
    }
    
    public func configureSecondStageInfo(model: [Rocket]?, curentPage: Int) {
        contentStackView.subviews.forEach({$0.removeFromSuperview()})
        if let model = model?[curentPage] {
            rocketNameLabel.text = Constants.secondStage
            configureTitle(label: rocketInfoModel.amountOfEngines, info: String(model.secondStage.engines))
            configureTitle(label: rocketInfoModel.amountOfFuel, info: String(model.secondStage.fuelAmountTons) + Constants.weightMeasure)
            if let burnTimeSEC = model.secondStage.burnTimeSEC {
                configureTitle(label: rocketInfoModel.timeOfBurn, info: String(burnTimeSEC) + Constants.timeMeasure)
            }
        }
    }
    
    public func updateDataSource(measureType: SettingsModel.ParameterType, tag: Int) {
        let model = rocketModel?[currentPage]
        switch tag {
        case 0:
            if let firstValue = model?.height.feet, let secondValue = model?.height.meters {
                rocketValues[tag] = measureType == .ft ? String(firstValue) : String(secondValue)
            }
        case 1:
            if let firstValue = model?.diameter.feet, let secondValue = model?.diameter.meters {
                rocketValues[tag] = measureType == .ft ? String(firstValue) : String(secondValue)
            }
        case 2:
            if let firstValue = model?.mass.kg, let secondValue = model?.mass.lb {
                rocketValues[tag] = measureType == .kg ? String(firstValue) : String(secondValue)
            }
        case 3:
            if let firstValue = model?.payloadWeights.first?.kg, let secondValue = model?.payloadWeights.first?.lb {
                rocketValues[tag] = measureType == .kg ? String(firstValue) : String(secondValue)
            }
        default: break
        }
        сharacteristicsCollectionView.reloadData()
    }
    
    
    //MARK: - private methods
    private func configureTitle(label: String, info: String) {
        let view = UIView()
        view.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        let titleForSettings = UILabel()
        view.addSubview(titleForSettings)
        titleForSettings.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(40)
        }
        titleForSettings.textColor = .white
        titleForSettings.text = label
        
        let infoForSettings = UILabel()
        view.addSubview(infoForSettings)
        infoForSettings.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(40)
            make.width.equalTo(170)
        }
        infoForSettings.textColor = .white
        infoForSettings.text = info
        infoForSettings.textAlignment = .right
        
        contentStackView.addArrangedSubview(view)
    }
    
    private func configureRocketValues(model: [Rocket]?, curentPage: Int) {
        rocketValues.removeAll()
        if let firstModel = model?[curentPage],
            let height = firstModel.height.meters,
            let payload = firstModel.payloadWeights.first?.kg,
            let diameter = firstModel.diameter.meters {
                rocketValues.append(String(height))
                rocketValues.append(String(diameter))
                rocketValues.append(String(firstModel.mass.kg))
                rocketValues.append(String(payload))
            }
        сharacteristicsCollectionView.reloadData()
    }
    
    //MARK: - objc method
    @objc private func tapSettingsButton() {
        delegate?.didTapSettingsButton()
    }
    
}

//MARK: - DataSource
extension RocketInfoView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rocketValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.сharacteristicsCollectionView.dequeueReusableCell(withReuseIdentifier: ParametersCell.identifier, for: indexPath) as? ParametersCell else { return UICollectionViewCell() }
        cell.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        cell.layer.cornerRadius = 30
        if let model = params?.items {
            cell.configureCollectionViewCell(parameter: model[indexPath.row], value: rocketValues[indexPath.row])
        }
        return cell
    }
    
}

//MARK: - DelegateFlowLayout
extension RocketInfoView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
