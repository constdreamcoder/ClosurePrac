//
//  UIViewControllerConfigurationProtocol.swift
//  ValueTransferPrac
//
//  Created by SUCHAN CHANG on 2/7/24.
//

import UIKit

protocol UIViewControllerConfigurationProtocol: AnyObject {
    func configureNavigationBar()
    func configureConstraints()
    func configureUI()
    func configureOthers()
    func configureUserEvents()
}
