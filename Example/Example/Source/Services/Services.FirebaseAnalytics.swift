//
//  Services.FirebaseAnalytics.swift
//  Oculis_Example
//
//  Created by Sergey Krumin on 10/21/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Astrarium
import Oculis

extension ServiceIds {

  static let firebaseAnalytics = ServiceIdentifier<FirebaseAnalyticsProvider> {
    return FirebaseAnalyticsProvider()
  }
}
