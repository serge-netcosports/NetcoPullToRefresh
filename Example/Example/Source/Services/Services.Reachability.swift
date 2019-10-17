//
//  Services.Reachability.swift
//  Oculis_Example
//
//  Created by Sergey Krumin on 10/14/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import Astrarium
import protocol Oculis.Reachable
import RxSwift

extension ServiceIds {

  static let reachablity = ServiceIdentifier<ReachablityService>()
}

final class ReachablityService: AppService, Reachable {

  private let reachable = Observable<Bool>.of(true, true)

  func setup(with launchOptions: LaunchOptions) {

  }

  var isReachable: Observable<Bool> {
    return reachable.share()
  }
}
