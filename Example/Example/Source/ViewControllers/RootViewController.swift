//
//  RootViewController.swift
//  Oculis_Example
//
//  Created by Sergey Krumin on 10/22/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Astrarium

class RootViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .lightGray
    navigationItem.title = "Root"

    logScreen()
  }

  func logScreen() {
    guard let analytics = Dispatcher.shared[.analytics] else { return }
    analytics.log(AnalyticsEvents.squadTab(tab: .all))
  }
}
