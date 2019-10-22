//
//  SplashViewController.swift
//  Oculis_Example
//
//  Created by Sergey Krumin on 10/22/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Astrarium

class SplashViewController: UIViewController {

  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Splash"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 24, weight: .black)
    return label
  }()

  let activityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .gray)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.hidesWhenStopped = false
    indicator.startAnimating()
    return indicator
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    setupLayout()
  }
}

extension SplashViewController {

  func setupLayout() {
    view.addSubview(titleLabel)
    view.addSubview(activityIndicator)

    var constraints = [
      titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
      titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ]
    if #available(iOS 11.0, *) {
      constraints.append(activityIndicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
    } else {
      constraints.append(activityIndicator.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor))
    }

    constraints.forEach { $0.isActive = true }
  }
}
