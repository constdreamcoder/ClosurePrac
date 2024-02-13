//
//  InputViewController.swift
//  ValueTransferPrac
//
//  Created by SUCHAN CHANG on 2/8/24.
//

import UIKit
import SnapKit

final class InputViewController: UIViewController {
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = navigationTitle
        textField.attributedPlaceholder = NSAttributedString(string: navigationTitle, attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 18.0)
        textField.setClearButton(with: UIImage(systemName: "x.circle.fill")!.withTintColor(.lightGray, renderingMode: .alwaysOriginal), mode: .always)
        return textField
    }()
    
    private var navigationTitle: String = ""
    
    var transferTextClosure: ((String) -> Void)?
    
    init(navigationTitle: String, inputLabelText: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationTitle = navigationTitle
        if inputLabelText != navigationTitle {
            inputTextField.text = inputLabelText
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureConstraints()
        configureUI()
        configureOthers()
        configureUserEvents()
    }
}

extension InputViewController {
    @objc func backgroundViewTapped() {
        view.endEditing(true)
    }
}

extension InputViewController: UIViewControllerConfigurationProtocol {
    func configureNavigationBar() {
        navigationItem.title = navigationTitle
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    func configureConstraints() {
        view.addSubview(inputTextField)
        
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16.0)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .black
    }
    
    func configureOthers() {
        inputTextField.delegate = self
    }
    
    func configureUserEvents() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped)))
    }
}

extension InputViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let inputText = textField.text,
              let transferTextClosure = transferTextClosure
        else { return }
        if inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            transferTextClosure(navigationTitle)
        } else {
            transferTextClosure(inputText)
        }
    }
}
