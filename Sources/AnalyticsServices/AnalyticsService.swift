//
//  AnalyticsService.swift
//  Astrarium
//
//  Created by Sergey Krumin on 10/21/19.
//

import Foundation
import Astrarium

// MARK: - Analytics Provider

public protocol AnalyticsProvider {
  func log(_ eventName: String, parameters: [String: Any]?)
}

// MARK: - Analytics Event

public protocol AnalyticsEvent {
  func name(for provider: AnalyticsProvider) -> String?
  func parameters(for provider: AnalyticsProvider) -> [String: Any]?
}

// MARK: - Analytics Service

public typealias AnalyticableService = AppService & AnalyticsProvider

public final class AnalyticsService: AppService {

  public func setup(with launchOptions: LaunchOptions) {}

  private(set) public var providers = [AnalyticableService]()

  public init() {
    print("Analytics enabled")
  }

  public func register(provider: AnalyticableService) {
    self.providers.append(provider)
  }

  public func log(_ event: AnalyticsEvent) {
    for provider in providers {
      guard let eventName = event.name(for: provider) else { continue }
      let parameters = event.parameters(for: provider)
      provider.log(eventName, parameters: parameters)
    }
  }
}
