//
//  AppDelegate.swift
//  Oculis_Example
//
//  Created by Sergey Krumin on 10/9/19.
//  Copyright © 2019 NetcoSports. All rights reserved.
//

import UIKit
import Astrarium
import RxSwift
import Oculis

@UIApplicationMain
class AppDelegate: Astrarium.AppDelegate {

  public var window: UIWindow? {
    get { return Dispatcher.shared[.coordinator]?.window }
    set { assertionFailure("window setted should not be called directly") }
  }

  public override var services: [ServiceIds?] { return [
    .reachablity,
    .config,
    .coordinator,
    .firebaseAnalytics,
    .analytics
    ]
  }
}
