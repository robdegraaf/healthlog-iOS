import Foundation
@testable import HealthLog
import Testing

/// ``AppLanguage`` maps a tag to the interface language the app actually ships
/// (de / en / nl), so server prose, on-device prompts and the PDF follow the
/// visible copy instead of the device language.
@Suite("AppLanguage")
struct AppLanguageTests {
    @Test("Shipped languages resolve by their primary subtag, any region or separator")
    func shippedLanguages() {
        #expect(AppLanguage.resolve("de") == .de)
        #expect(AppLanguage.resolve("de_AT") == .de)
        #expect(AppLanguage.resolve("en-GB") == .en)
        #expect(AppLanguage.resolve("nl") == .nl)
        #expect(AppLanguage.resolve("nl-BE") == .nl)
        #expect(AppLanguage.resolve("NL_nl") == .nl)
    }

    @Test("A language the app does not ship reads English, like the interface itself")
    func unshippedLanguagesReadEnglish() {
        // Before AppLanguage a French device fell through to German prose.
        #expect(AppLanguage.resolve("fr") == .en)
        #expect(AppLanguage.resolve("fr_FR") == .en)
        #expect(AppLanguage.resolve("") == .en)
        #expect(AppLanguage.resolve(nil as String?) == .en)
    }

    @Test("A Locale resolves the same way as its identifier")
    func localeResolution() {
        #expect(AppLanguage.resolve(Locale(identifier: "nl_NL")) == .nl)
        #expect(AppLanguage.resolve(Locale(identifier: "de_CH")) == .de)
        #expect(AppLanguage.resolve(Locale(identifier: "it_IT")) == .en)
    }

    @Test("Server codes: every language for open endpoints, de/en only for the chat bodies")
    func serverCodes() {
        #expect(AppLanguage.nl.serverCode == "nl")
        #expect(AppLanguage.de.twoLocaleServerCode == "de")
        #expect(AppLanguage.en.twoLocaleServerCode == "en")
        // The Coach / document chat body schema refuses "nl" with a 422; the
        // field is left out and the server resolves the reader's language.
        #expect(AppLanguage.nl.twoLocaleServerCode == nil)
    }

    @Test("The current language is always one the app ships")
    func currentIsShipped() {
        #expect(AppLanguage.allCases.contains(AppLanguage.current))
    }
}
