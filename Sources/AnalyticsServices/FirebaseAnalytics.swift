//
//  FirebaseAnalytics.swift
//  Astrarium
//
//  Created by Sergey Krumin on 10/21/19.
//

import Foundation
import FirebaseCore
import FirebaseAnalytics
import Astrarium

public class FirebaseAnalyticsProvider: AnalyticableService {

  required public init() {}

  public func setup(with launchOptions: LaunchOptions) {

    ///
    /// Add GoogleService-Info.plist files to your project
    /// adding some environment strings at the end. Then uncomment
    /// lines below
    ///

    /*
    guard let options = FirebaseOptions(contentsOfFile: "FIREBASE_PLIST_PATH") else {
      assertionFailure("Invalid Firebase configuration file.")
      return
    }
    FirebaseApp.configure(options: options)
    */
  }

  public func log(_ eventName: String, parameters: [String : Any]?) {
    Analytics.logEvent(eventName, parameters: parameters)
  }
}
