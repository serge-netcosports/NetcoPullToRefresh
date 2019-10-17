//
//  ConfigModel.swift
//  Oculis_Example
//
//  Created by Sergey Krumin on 10/14/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Oculis
import Gnomon
import SwiftyJSON

struct ConfigModel: JSONModel, VersionCheckable {
  var appVersion: AppVersionable?

  init(_ container: JSON) throws {
    appVersion = try AppVersion(container["force_update"]["ios"])
  }
}
