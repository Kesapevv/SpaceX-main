//
//  RocketsViewController.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 10/21/22.
//  
//

import UIKit
import Kingfisher

final class RocketsViewController: UIViewController {
    
    //MARK: - Properties
    var presenter: ViewToPresenterRocketsProtocol?
    
    private var rocketID: String = ""
    private var rocketName: String = ""
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var rocketImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var backgroundForInfo: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    private lazy var mainInfoView: RocketInfoView = {
        let view = RocketInfoView(withCollection: true)
        view.delegate = self
        return view
    }()
    
    private var firstStageInfoView: RocketInfoView = {
        let view = RocketInfoView(withCollection: false)
        return view
    }()
    
    private var secondStageInfoView: RocketInfoView = {
        let view = RocketInfoView(withCollection: false)
        return view
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        pageControl.addTarget(self, action: #selector(changePage), for: .valueChanged)
        return pageControl
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainInfoView, firstStageInfoView, secondStageInfoView])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var launchButton: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        let label = UILabel()
        label.text = Constants.launchButton
        label.textColor = .white
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationController?.isNavigationBarHidden = true
        configureUI()
    }
        
    //MARK: - Private method
    private func configureUI() {
                
        view.addSubview(rocketImage)
        rocketImage.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1220)
        }
        
        contentView.addSubview(backgroundForInfo)
        backgroundForInfo.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(350)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        backgroundForInfo.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.leading.trailing.equalToSuperview()
        }
        
        backgroundForInfo.addSubview(launchButton)
        launchButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(40)
        }
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(72)
        }
        
        launchButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLaunchButton)))
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(changePageBySwipe(sender:)))
        swipeRight.direction = .right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(changePageBySwipe(sender:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }
    
    private func configureData(model: [Rocket]?, params: ParametersModel?) {
        if let url = URL(string: model?[pageControl.currentPage].flickrImages.first ?? "") {
            rocketImage.kf.setImage(with: url, placeholder: UIImage(named: "falcon1"))
        }
        if let model = model?[pageControl.currentPage] {
            rocketID = model.id
            rocketName = model.name
        }
        mainInfoView.configureMainInfo(model: model, curentPage: pageControl.currentPage, params: params)
        firstStageInfoView.configureFirstStageInfo(model: model, curentPage: pageControl.currentPage)
        secondStageInfoView.configureSecondStageInfo(model: model, curentPage: pageControl.currentPage)
    }
    
    //MARK: - objc method
    @objc private func tapLaunchButton() {
        presenter?.didTapLaunchButton(rocketID: rocketID, rocketName: rocketName)
    }
    
    @objc private func changePage() {
        succes(model: presenter?.getRocketModel(), params: presenter?.getParamsModel())
    }
    
    @objc private func changePageBySwipe(sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            pageControl.currentPage += 1
        } else if sender.direction == .right {
            pageControl.currentPage -= 1
        }
        changePage()
    }
}

//MARK: - PresenterToViewRocketsProtocol
extension RocketsViewController: PresenterToViewRocketsProtocol {
    func succes(model: [Rocket]?, params: ParametersModel?) {
        if let countOfRockets = model?.count {
            configureData(model: model, params: params)
            pageControl.numberOfPages = countOfRockets
        }
    }
    
    func failure(error: Error) {
        let alertController = UIAlertController(title: "Error!", message: "Check your internet connection", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try again!", style: .default) { [weak self] _ in
            self?.presenter?.viewDidLoad()
            })
        self.present(alertController, animated: true)
    }
}

//MARK: - RocketInfoViewDelegate
extension RocketsViewController: RocketInfoViewDelegate {
    func didTapSettingsButton() {
        let settingsVC = SettingsRouter.createModule(params: presenter?.getParamsModel()) as? SettingsViewController
        settingsVC?.delegate = self
        if let vc = settingsVC {
            navigationController?.present(vc, animated: true)
        }
    }
}

//MARK: - SettingsViewControllerDelegate
extension RocketsViewController: SettingsViewControllerDelegate {
    func didChangeState(measureType: SettingsModel.ParameterType, tag: Int) {
        mainInfoView.updateDataSource(measureType: measureType, tag: tag)
    }
}
