//
//  CustomInputContainerView.swift
//  ValueTransferPrac
//
//  Created by SUCHAN CHANG on 2/7/24.
//

import UIKit
import SnapKit

final class CustomInputContainerView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "사용자 이름"
        label.textColor = .white
        return label
    }()
    
    let inputLabel: UILabel = {
        let label = UILabel()
        label.text = "이름을 입력해주세요"
        label.textColor = .darkGray
        return label
    }()
    
    init(title: String = "", inputPlaceholder: String = "") {
        super.init(frame: .zero)
        
        [titleLabel, inputLabel].forEach { addSubview($0) }
        configureConstraints()
        initializeSubViews(title: title, inputPlaceholder: inputPlaceholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        inputLabel.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(78.0)
            $0.centerY.equalTo(inputLabel)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(inputLabel.snp.leading).offset(-24.0)
        }
    }
    
    private func initializeSubViews(title: String?, inputPlaceholder: String?) {
        guard let title = title,
              let inputPlaceholder = inputPlaceholder
        else { return }
        
        titleLabel.text = title
        inputLabel.text = inputPlaceholder
    }
}
