import CoreText
import Foundation
import SwiftUI

enum OrionFont {
    private static let subwayTickerGridPostScriptName = "SubwayTickerGrid"

    static func subwayTickerGrid(size: CGFloat, relativeTo textStyle: Font.TextStyle) -> Font {
        registerFonts()
        return .custom(subwayTickerGridPostScriptName, size: size, relativeTo: textStyle)
    }

    private static func registerFonts() {
        _ = registeredFonts
    }

    private static let registeredFonts: Void = {
        registerFont(resourceName: "SubwayTickerGrid", fileExtension: "ttf")
    }()

    private static func registerFont(resourceName: String, fileExtension: String) {
        let bundle = Bundle.main
        let fontURL =
            bundle.url(forResource: resourceName, withExtension: fileExtension)
            ?? bundle.url(forResource: resourceName, withExtension: fileExtension, subdirectory: "Fonts")
            ?? bundle.url(forResource: resourceName, withExtension: fileExtension, subdirectory: "Design/Fonts")

        guard let fontURL else {
            assertionFailure("Missing font resource: \(resourceName).\(fileExtension)")
            return
        }

        var registrationError: Unmanaged<CFError>?
        let didRegister = CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &registrationError)

        guard !didRegister, let registrationError else { return }
        let error = registrationError.takeRetainedValue()
        assertionFailure("Could not register font \(fontURL.lastPathComponent): \(error)")
    }
}
