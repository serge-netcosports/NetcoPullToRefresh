# Oculis

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

```ruby
pod 'Oculis', :git => 'git@github.com:netcosports/Oculis.git'
```

## Subspecs

All services are available in separated subspecs:

### Core

```ruby
pod 'Oculis/Core'
```

Contains `ConfigService`

This is a service for downloading a remote config. ConfigService is a generic type so you should provide your model which conforms protocols `BaseModel & VersionCheckable`.

```swift
struct ConfigModel: JSONModel, VersionCheckable {
  var appVersion: AppVersionable?

  init(_ container: JSON) throws {
    appVersion = try AppVersion(container["force_update"]["ios"])
  }
}
```

You should provide ConfigService with `Settings`. Settings can be created in two ways:

```swift
// Init settings with init url and local config name
let settings = Config.Settings(initURL: url, localConfigName: "init")
```

or

```swift
// Init settings with request and local config name
let settings = Config.Settings(localConfigName: "init") {
  return try Request<ConfigModel>(URLString: url)
}
```

Сonfig service must provide Reachablity service and settings.

```swift
typealias Config = ConfigService<ConfigModel>

static let config = ServiceIdentifier<Config> {
  let url = "YOUR_CONFIG_URL"
  
  let settings = Config.Settings(initURL: url, localConfigName: "init")

  return Config(reachability: Dispatcher.shared[.reachablity], settings: settings)
}
```

### AnalyticsServices

```ruby
pod 'Oculis/AnalyticsServices'
```

Contains `AnalyticsService` and a set of commonly used analytics providers.

To use AnalyticsService you need to create a providers.

```swift
static let firebaseAnalytics = ServiceIdentifier<FirebaseAnalyticsProvider> {
  return FirebaseAnalyticsProvider()
}
```

register them at the stage of creating AnalyticsService

```swift
static let analytics = ServiceIdentifier<AnalyticsService> {
  let analyticsService = AnalyticsService()

  guard let firebaseAnalyticsService = Dispatcher.shared[.firebaseAnalytics] else {
    return analyticsService
  }
  analyticsService.register(provider: firebaseAnalyticsService)

  return analyticsService
}
```

Your analytics event need to conforms protocol `AnalyticsEvent` and provide name and parameters.

```swift
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
```

Now you can log your event

```swift
guard let analytics = Dispatcher.shared[.analytics] else { return }

analytics.log(AnalyticsEvents.squadTab(tab: .all))
```
