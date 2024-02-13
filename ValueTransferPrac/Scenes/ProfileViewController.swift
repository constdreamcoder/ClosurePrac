//
//  ProfileViewController.swift
//  ValueTransferPrac
//
//  Created by SUCHAN CHANG on 2/7/24.
//

import UIKit
import SnapKit
import UnsplashPhotoPicker
import Kingfisher

final class ProfileViewController: UIViewController {
    
    let profileButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 100)
        let buttonImage = UIImage(systemName: "person.circle.fill", withConfiguration: config)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(buttonImage, for: .normal)
        button.layer.cornerRadius = 100 / 2
        button.clipsToBounds = true
        return button
    }()
    
    lazy var inputContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 36.0
        stackView.distribution = .equalSpacing
        titleList.forEach {
            let inputContainerView = CustomInputContainerView(title: $0, inputPlaceholder: $0)
            stackView.addArrangedSubview(inputContainerView)
        }
        return stackView
    }()
    
    let titleList: [String] = ["이름", "사용자 이름", "성별 대명사"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureConstraints()
        configureUserEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "프로필 편집"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
    }
}

extension ProfileViewController {
    @objc func leftBarButtonItemTapped(_ barButtonItem: UIBarButtonItem) {
        print(#function)
    }
    
    @objc func rightBarButtonItemTapped(_ barButtonItem: UIBarButtonItem) {
        print(#function)
    }
    
    @objc func inputLabelTapped(_ gestureRecognizer: UIGestureRecognizer) {
        print(#function)
        guard let inputContainerView = gestureRecognizer.view?.superview as? CustomInputContainerView else { return }
        
        let inputVC = InputViewController(navigationTitle: inputContainerView.titleLabel.text ?? "", inputLabelText: inputContainerView.inputLabel.text ?? "")
        inputVC.transferTextClosure = { text in
            inputContainerView.inputLabel.text = text
            
            if text != inputContainerView.titleLabel.text {
                inputContainerView.inputLabel.textColor = .white
            } else {
                inputContainerView.inputLabel.textColor = .darkGray
            }
        }
        
        navigationController?.pushViewController(inputVC, animated: true)
    }
    
    @objc func profileButtonTapped() {
        let configuration = UnsplashPhotoPickerConfiguration(
            accessKey: APIKeys.accessKey,
            secretKey: APIKeys.secretKey
        )
        let unsplashPhotoPicker = UnsplashPhotoPicker(configuration: configuration)
        unsplashPhotoPicker.photoPickerDelegate = self
        
        present(unsplashPhotoPicker, animated: true, completion: nil)
    }
}

extension ProfileViewController: UIViewControllerConfigurationProtocol {
    func configureNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 17.0, weight: .bold)]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftBarButtonItemTapped))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
    }
    
    func configureConstraints() {
        [
            profileButton,
            inputContainerStackView
        ].forEach { view.addSubview($0) }
        
        profileButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16.0)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.size.equalTo(100.0)
        }
        
        inputContainerStackView.snp.makeConstraints {
            $0.top.equalTo(profileButton.snp.bottom).offset(16.0)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16.0)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .black
    }
    
    func configureOthers() {
        
    }
    
    func configureUserEvents() {
        inputContainerStackView.arrangedSubviews.forEach {
            guard let inputContainerView = $0 as? CustomInputContainerView else { return }
            
            inputContainerView.inputLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(inputLabelTapped)))
            inputContainerView.inputLabel.isUserInteractionEnabled = true
        }
        
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }
}

extension ProfileViewController: UnsplashPhotoPickerDelegate {
    func unsplashPhotoPicker(_ photoPicker: UnsplashPhotoPicker, didSelectPhotos photos: [UnsplashPhoto]) {
        guard let url = photos[0].urls[.regular] else { return }
        
        let placeholderImage = UIImage(systemName: "person.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        profileButton.kf.setImage(with: url, for: .normal, placeholder: placeholderImage)        
    }
    
    func unsplashPhotoPickerDidCancel(_ photoPicker: UnsplashPhotoPicker) {
        print("Unsplash photo picker did cancel")
    }
}
