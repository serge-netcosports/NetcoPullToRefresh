//
//  Common.swift
//  Oculis
//
//  Created by Sergey Krumin on 10/11/19.
//

import RxSwift

public protocol Reachable {
  var isReachable: Observable<Bool> { get }
}

public enum AppVersionStatus {
  case optional, mandatory
}

public protocol AppVersionable {
  var status: AppVersionStatus? { get set }
  var updateURL: URL { get set }
}

public protocol VersionCheckable {
  var appVersion: AppVersionable? { get set }
}
