//
//  Services.Coordinator.swift
//  Oculis_Example
//
//  Created by Sergey Krumin on 10/22/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Astrarium
import RxSwift

extension ServiceIds {

  static let coordinator = ServiceIdentifier<UICoordinator>()
}

final class UICoordinator: AppService {

  let window = UIWindow(frame: UIScreen.main.bounds)
  let disposeBag = DisposeBag()

  // MARK: - Lifecycle

  func setup(with _: LaunchOptions) {
    showSplash()
  }

  func appInterfaceOrientationMask(for _: UIWindow?) -> UIInterfaceOrientationMask {
    return .allButUpsideDown
  }
}

// MARK: Public

extension UICoordinator {

  func showSplash() {
    let splash = SplashViewController()
    window.rootViewController = splash
    window.makeKeyAndVisible()

    loadConfig { [weak self] in
      self?.showRoot()
    }
  }

  func showRoot(completion: (() -> Void)? = nil) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
      let rootViewController = RootViewController()
      let navigation = UINavigationController(rootViewController: rootViewController)
      self?.window.rootViewController = navigation
    }
  }
}

// MARK: - Private

private extension UICoordinator {

  func loadConfig(completion: @escaping () -> Void) {
    if let config = Dispatcher.shared[.config] {
      config.rx.ready
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { config in
          print("Config did load: \(config)")
          completion()
        }).disposed(by: disposeBag)
    }
  }
}
