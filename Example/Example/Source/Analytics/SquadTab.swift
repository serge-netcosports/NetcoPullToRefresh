//
//  SquadTab.swift
//  Oculis_Example
//
//  Created by Sergey Krumin on 10/21/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Oculis

enum SquadTab: String {
  case all = "All"
  case defenders = "Defenders"
  case midfielders = "Midfielders"
  case forwards = "Forwards"
  case goalkeepers = "Goalkeepers"
}

enum AnalyticsEvents: AnalyticsEvent {

  case squadTab(tab: SquadTab)

  func name(for provider: AnalyticsProvider) -> String? {
    switch self {
    case .squadTab: return "squad_tab"
    }
  }

  func parameters(for provider: AnalyticsProvider) -> [String : Any]? {
    switch self {
    case let .squadTab(tab):
      return ["tab": tab.rawValue]
    }
  }
}
