// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen
// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// swiftlint:disable foundation_using

import Foundation

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum Localized {
  /// Привет
  internal static let hello = Localized.tr("Localizable", "Hello")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension Localized {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
