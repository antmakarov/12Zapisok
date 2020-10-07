// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Colors {

  }
  internal enum Icons {

    internal enum AppIcons {
      internal static let achievement = ImageAsset(name: "Icons/AppIcons/achievement")
      internal static let back = ImageAsset(name: "Icons/AppIcons/back")
      internal static let buildYear = ImageAsset(name: "Icons/AppIcons/buildYear")
      internal static let cityPin = ImageAsset(name: "Icons/AppIcons/cityPin")
      internal static let cityscape = ImageAsset(name: "Icons/AppIcons/cityscape")
      internal static let close = ImageAsset(name: "Icons/AppIcons/close")
      internal static let inProgressPlaceholder = ImageAsset(name: "Icons/AppIcons/inProgressPlaceholder")
      internal static let myPin = ImageAsset(name: "Icons/AppIcons/myPin")
      internal static let paper = ImageAsset(name: "Icons/AppIcons/paper")
      internal static let pieChart = ImageAsset(name: "Icons/AppIcons/pie-chart")
      internal static let placeholder = ImageAsset(name: "Icons/AppIcons/placeholder")
      internal static let population = ImageAsset(name: "Icons/AppIcons/population")
      internal static let purchaseMap = ImageAsset(name: "Icons/AppIcons/purchaseMap")
      internal static let regionCode = ImageAsset(name: "Icons/AppIcons/regionCode")
      internal static let route2 = ImageAsset(name: "Icons/AppIcons/route-2")
      internal static let settings2 = ImageAsset(name: "Icons/AppIcons/settings-2")
      internal static let targetMap = ImageAsset(name: "Icons/AppIcons/targetMap")
      internal static let treasure2 = ImageAsset(name: "Icons/AppIcons/treasure-2")
      internal static let unavailablePlaceholder = ImageAsset(name: "Icons/AppIcons/unavailablePlaceholder")
      internal static let warning = ImageAsset(name: "Icons/AppIcons/warning")
    }
    internal enum MenuCirclesColor {
      internal static let celestial = ImageAsset(name: "Icons/MenuCirclesColor/Celestial")
      internal static let orangeCoral = ImageAsset(name: "Icons/MenuCirclesColor/Orange Coral")
      internal static let scooter = ImageAsset(name: "Icons/MenuCirclesColor/Scooter")
      internal static let tonight = ImageAsset(name: "Icons/MenuCirclesColor/Tonight")
    }
    internal enum NoteBigColor {
      internal static let progressBig = ImageAsset(name: "Icons/NoteBigColor/progressBig")
      internal static let successBig = ImageAsset(name: "Icons/NoteBigColor/successBig")
      internal static let unavailableBig = ImageAsset(name: "Icons/NoteBigColor/unavailableBig")
    }
    internal enum NoteState {
      internal static let closeState = ImageAsset(name: "Icons/NoteState/CloseState")
      internal static let progressState = ImageAsset(name: "Icons/NoteState/ProgressState")
      internal static let successState = ImageAsset(name: "Icons/NoteState/SuccessState")
    }
    internal enum Onboarding {
      internal static let auth = ImageAsset(name: "Icons/Onboarding/auth")
      internal static let childhood = ImageAsset(name: "Icons/Onboarding/childhood")
      internal static let cityList = ImageAsset(name: "Icons/Onboarding/cityList")
      internal static let guessCity = ImageAsset(name: "Icons/Onboarding/guessCity")
      internal static let requestLocation = ImageAsset(name: "Icons/Onboarding/requestLocation")
    }
    internal static let onboarding32512 = ImageAsset(name: "Icons/Onboarding_3-2-512")
    internal static let rectangle = ImageAsset(name: "Icons/Rectangle")
    internal static let redRec = ImageAsset(name: "Icons/RedRec")
    internal enum SmallNote {
      internal static let graySmallNote = ImageAsset(name: "Icons/SmallNote/graySmallNote")
      internal static let greenSmallNote = ImageAsset(name: "Icons/SmallNote/greenSmallNote")
      internal static let orangeSmallNote = ImageAsset(name: "Icons/SmallNote/orangeSmallNote")
    }
    internal static let appBackground = ImageAsset(name: "Icons/appBackground")
    internal static let appLogo = ImageAsset(name: "Icons/appLogo")
    internal static let appPlaceholder = ImageAsset(name: "Icons/appPlaceholder")
    internal static let cityPlaceholder = ImageAsset(name: "Icons/cityPlaceholder")
    internal static let mechetKulSharif = ImageAsset(name: "Icons/mechet-kul-sharif")
    internal static let nn = ImageAsset(name: "Icons/nn")
    internal static let progressIcon = ImageAsset(name: "Icons/progressIcon")
    internal static let stop = ImageAsset(name: "Icons/stop")
    internal static let unavailableIcon = ImageAsset(name: "Icons/unavailableIcon")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name


// MARK: Color Assets Extension

public extension UIColor {
  @nonobjc class var AppColor: UIColor {
    return ColorAsset(name: "Colors/AppColor").color
  }
}

// MARK: - Implementation Details

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct DataAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  internal var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
internal extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
