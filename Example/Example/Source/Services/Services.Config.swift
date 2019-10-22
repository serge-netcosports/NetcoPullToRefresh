//
//  Services.Config.swift
//  Oculis_Example
//
//  Created by Sergey Krumin on 10/14/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Astrarium
import Oculis
import Gnomon
import SwiftyJSON

extension ServiceIds {

  typealias Config = ConfigService<ConfigModel>

  static let config = ServiceIdentifier<Config> {
    let url = "https://dl.dropboxusercontent.com/s/ybuxf7x7enmfo5d/legapro_init_dev.json"

    /*
    // Init settings with init url and local config name
    let settings = Config.Settings(initURL: url, localConfigName: "init")
    */
    
    // Init settings with request and local config name
    let settings = Config.Settings(localConfigName: "init") {
      return try Request<ConfigModel>(URLString: url)
        .setMethod(.GET)
    }

    return Config(reachability: Dispatcher.shared[.reachablity], settings: settings)
  }
}
