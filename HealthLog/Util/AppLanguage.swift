import Foundation

/// **The language the app's own interface renders in.**
///
/// iOS resolves `Bundle.main.preferredLocalizations` against the languages the
/// app ships (`CFBundleLocalizations`: de, en, nl), so its first entry is the
/// language every catalogue string on screen is in. `Locale.current` is the
/// DEVICE language and can name one the app does not ship: a French phone
/// renders the English interface, yet `Locale.current.language.languageCode`
/// says "fr". Before this type, every `languageCode == "en" ? "en" : "de"`
/// branch sent that reader German server prose, German on-device prompts and
/// a German PDF under an English interface, and every Dutch reader the same.
///
/// Anything whose text must match the visible copy (server-rendered prose, the
/// on-device model's prompts and output language, the doctor report) reads
/// this type instead of `Locale.current`.
public enum AppLanguage: String, Sendable, CaseIterable, Equatable {
    case de
    case en
    case nl

    /// The interface language right now. Never a language the app does not
    /// ship; English when the bundle answers nothing (the catalogue's
    /// `sourceLanguage` and the project's `developmentLanguage`).
    public static var current: AppLanguage {
        resolve(Bundle.main.preferredLocalizations.first)
    }

    /// Map a language tag ("nl", "nl-BE", "de_AT", "en-US") to a shipped
    /// language by its primary subtag. Anything else reads English, the
    /// language the interface itself falls back to.
    public static func resolve(_ identifier: String?) -> AppLanguage {
        guard let identifier else { return .en }
        let primary = identifier
            .lowercased()
            .split(whereSeparator: { $0 == "-" || $0 == "_" })
            .first
            .map(String.init) ?? ""
        return AppLanguage(rawValue: primary) ?? .en
    }

    /// Same mapping for a `Locale`, for the services that take one as a
    /// parameter (on-device prompts, tests that pin a language).
    public static func resolve(_ locale: Locale) -> AppLanguage {
        resolve(locale.language.languageCode?.identifier)
    }

    /// A `Locale` for formatting in this language (dates, numbers, the
    /// on-device model's locale). Region-neutral on purpose: a Belgian reader
    /// of Dutch keeps their region through `Locale.current` wherever the
    /// region matters.
    public var locale: Locale {
        Locale(identifier: rawValue)
    }

    /// The `locale` for a server endpoint that accepts every interface
    /// language (narratives, status prose, derived insights, the health-record
    /// export, medication extraction, the screeners).
    public var serverCode: String {
        rawValue
    }

    /// The `locale` for the two server endpoints whose request body still
    /// accepts only `de` / `en` (Coach chat, document chat). `nil` for any
    /// other language: the field is then left out and the server resolves the
    /// reader's language itself (account language, then `Accept-Language`),
    /// which names Dutch where sending "nl" would be refused with a 422.
    public var twoLocaleServerCode: String? {
        switch self {
        case .de, .en: rawValue
        case .nl: nil
        }
    }
}
