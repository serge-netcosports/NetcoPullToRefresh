//
//  Config.AppVersion.swift
//  Oculis_Example
//
//  Created by Sergey Krumin on 10/14/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Oculis
import Gnomon
import SwiftyJSON

extension ConfigModel {

  struct AppVersion: JSONModel, AppVersionable {
    public var status: AppVersionStatus?

    public var updateURL: URL

    public init(_ container: JSON) throws {
      guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
        throw "\(#file):\(#line) — could not retrieve app version"
      }

      guard let current = container["current_version"].string else {
        throw "\(#file):\(#line) — could not parse current version"
      }
      let newVersionAvailable = current.compare(version, options: String.CompareOptions.numeric) == .orderedDescending

      guard let min = container["min_version"].string else {
        throw "\(#file):\(#line) — could not parse min version"
      }
      let updateRequired = min.compare(version, options: String.CompareOptions.numeric) == .orderedDescending

      if updateRequired {
        status = .mandatory
      } else if newVersionAvailable {
        status = .optional
      } else {
        status = nil
      }

      guard let updateURL = container["update_url"].url else {
        throw "\(#file):\(#line) — could not parse update URL"
      }
      self.updateURL = updateURL
    }
  }
}
