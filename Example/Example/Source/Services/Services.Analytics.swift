//
//  Services.Analytics.swift
//  Oculis_Example
//
//  Created by Sergey Krumin on 10/21/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Astrarium
import Oculis
import Gnomon
import SwiftyJSON

extension ServiceIds {

  static let analytics = ServiceIdentifier<AnalyticsService> {
    let analyticsService = AnalyticsService()

    guard let firebaseAnalyticsService = Dispatcher.shared[.firebaseAnalytics] else {
      return analyticsService
    }
    analyticsService.register(provider: firebaseAnalyticsService)

    return analyticsService
  }
}
