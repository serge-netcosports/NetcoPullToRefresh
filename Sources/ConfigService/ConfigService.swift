import RxSwift
import Astrarium
import Gnomon

public final class ConfigService<Model: BaseModel & VersionCheckable>: AppService {

  // MARK: - Init

  public init() {
    fatalError("You must use init(settings:)")
  }

  public init(reachability: Reachable?, settings: Settings) {
    self.reachability = reachability
    self.settings = settings
    self.checkSettings()
  }

  // MARK: - Public Instances

  public let settings: Settings
  public var config: Model { return remoteConfig ?? localConfig }

  public lazy var rx: Reactive<Model> = {
    return Reactive(self)
  }()

  // MARK: - Private Instances

  private let reachability: Reachable?

  private let _ready = ReplaySubject<Model>.create(bufferSize: 1)
  private lazy var localConfig = loadLocalConfig()
  private var remoteConfig: Model?

  private let disposeBag = DisposeBag()

  // MARK: - Setup

  public func setup(with _: LaunchOptions) {
    guard let reachability = reachability else {
      self.loadRemoteConfig()
      return
    }
    reachability.isReachable
      .skip(1)
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] isReachable in
        guard let self = self else { return }

        if isReachable || self.remoteConfig == nil {
           self.loadRemoteConfig()
        }
      }).disposed(by: disposeBag)
  }
}

// MARK: - Config Settings

extension ConfigService {

  public class Settings {

    public typealias RequesProvider = () throws -> Request<Model>

    public let localConfigName: String
    public var initURL: String = ""
    public var initRequest: RequesProvider?

    public init(localConfigName: String, initRequest: RequesProvider? = nil) {
      self.localConfigName = localConfigName
      self.initRequest = initRequest
    }

    public init(initURL: String, localConfigName: String) {
      self.localConfigName = localConfigName
      self.initURL = initURL
    }
  }
}
// MARK: - Private methods

private extension ConfigService {

  func configRequest() throws -> Request<Model>? {
    if let request = settings.initRequest {
      return try request()
    }

    return try? Request(URLString: settings.initURL)
      .setMethod(.GET)
  }

  func loadRemoteConfig() {
    guard let configRequest = try? configRequest() else {
      assertionFailure("You should provide right config request")
      _ready.onNext(localConfig)
      
      return
    }

    Gnomon.models(for: configRequest)
      .map { $0.result }
      .do(onNext: { self.remoteConfig = $0 })
      .catchError { _ in .just(self.localConfig) }
      .subscribe(onNext: { self._ready.onNext($0) })
      .disposed(by: disposeBag)
  }

  func loadLocalConfig() -> Model {
    guard let url = Bundle.main.url(forResource: settings.localConfigName, withExtension: "json"),
      let data = try? Data(contentsOf: url, options: []),
      let json = try? Model.DataContainer.container(with: data, at: nil) else {
      fatalError("can't find default config file")
    }

    guard let localConfig = try? Model(json) else {
      fatalError("can't load default config file")
    }
    return localConfig
  }

}

private extension ConfigService {

  private func checkSettings() {
    checkValueExistance(settings.localConfigName, propertyName: "localConfigName")
    if settings.initRequest == nil {
      checkValueExistance(settings.initURL, propertyName: "initURL")
    }
  }
  private func checkValueExistance(_ value: String, propertyName: String) {

    if value.isEmpty {
      assertionFailure("You should provide right value for \(propertyName)")
    }
  }
}

// MARK: - Reactive

extension ConfigService {

  public struct Reactive<Model: BaseModel> where Model: VersionCheckable {
    let base: ConfigService<Model>

    fileprivate init(_ base: ConfigService<Model>) {
      self.base = base
    }
  }
}

extension ConfigService.Reactive {

  public var ready: Observable<Model> {
    return base._ready.take(1)
  }
}
