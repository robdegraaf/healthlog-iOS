import Foundation
@testable import HealthLog
import Testing

/// **The Dutch screener wording is the published validated text, not ours.**
///
/// Re-wording a validated instrument changes what it measures. The server
/// carries the published Dutch versions (`src/lib/mental-health/wording/*/nl.ts`:
/// Pfizer's "Dutch for the Netherlands" PHQ-9 and GAD-7, the WHO-5 Dutch
/// version), so the catalogue's `nl` values reproduce those word for word and
/// ``MentalHealthInstrument/validatedItemLocales`` lists "nl" for the three.
/// The one deviation: PHQ-9 item 6 reads ", of" where the sheet prints " — of",
/// because the visible-punctuation gate forbids the em dash in catalogue values.
///
/// The SCI has no validated Dutch version: its items stay the English original
/// (``MentalHealthSciLocalisationTests``), and the submit says so with
/// `englishOriginal`, so the server records `original_en` instead of a
/// translation the reader never saw.
@Suite("Dutch screener wording (validated text)")
struct MentalHealthDutchWordingTests {
    private static func nl(_ key: String) throws -> String {
        let catalog = try ParityCatalog.load()
        let entry = try #require(catalog.strings[key], "missing catalog entry \(key)")
        return try #require(ParityCatalog.value(entry, language: "nl"), "\(key) has no nl value")
    }

    @Test("PHQ-9, GAD-7 and WHO-5 count as validated in Dutch; the SCI does not")
    func validatedLocales() {
        for instrument in [MentalHealthInstrument.phq9, .gad7, .who5] {
            #expect(instrument.validatedItemLocales.contains("nl"))
            #expect(instrument.hasValidatedItems(locale: "nl_NL"))
            #expect(instrument.hasValidatedItems(locale: "nl-BE"))
        }
        #expect(!MentalHealthInstrument.sci.hasValidatedItems(locale: "nl"))
    }

    @Test("The PHQ-9 safety item and anchors are the published Dutch text")
    func phq9Wording() throws {
        #expect(try Self.nl("mentalHealth.items.phq9.9")
            == "De gedachte dat u beter dood zou kunnen zijn of de gedachte uzelf op een bepaalde manier pijn te doen")
        #expect(try Self.nl("mentalHealth.stem")
            == "Hoe vaak hebt u in de afgelopen 2 weken last gehad van één of meer van de volgende problemen?")
        #expect(try Self.nl("mentalHealth.options.0") == "Helemaal niet")
        #expect(try Self.nl("mentalHealth.options.1") == "Verscheidene dagen")
        #expect(try Self.nl("mentalHealth.options.2") == "Meer dan de helft van de dagen")
        #expect(try Self.nl("mentalHealth.options.3") == "Bijna elke dag")
        #expect(try Self.nl("mentalHealth.functional.3") == "Extreem moeilijk")
    }

    @Test("GAD-7 and WHO-5 items are the published Dutch text")
    func gad7AndWho5Wording() throws {
        #expect(try Self.nl("mentalHealth.items.gad7.7") == "Bang zijn dat er iets vreselijks zou kunnen gebeuren")
        #expect(try Self.nl("mentalHealth.items.who5.1") == "Ik voelde me vrolijk en in een opperbeste stemming")
        #expect(try Self.nl("mentalHealth.stems.who5.period") == "Gedurende de laatste twee weken …")
        #expect(try Self.nl("mentalHealth.who5Options.5") == "Constant")
    }

    @Test("englishOriginal is on the wire when set and absent when nil")
    func englishOriginalWire() throws {
        let shownInEnglish = CreateAssessmentRequest(
            instrument: .sci,
            items: Array(repeating: 2, count: 8),
            locale: "nl",
            englishOriginal: true
        )
        let withFlag = try #require(
            JSONSerialization.jsonObject(with: JSONEncoder().encode(shownInEnglish)) as? [String: Any]
        )
        #expect(withFlag["englishOriginal"] as? Bool == true)
        #expect(withFlag["locale"] as? String == "nl")

        let validated = CreateAssessmentRequest(instrument: .phq9, items: Array(repeating: 0, count: 9), locale: "nl")
        let withoutFlag = try #require(
            JSONSerialization.jsonObject(with: JSONEncoder().encode(validated)) as? [String: Any]
        )
        #expect(withoutFlag["englishOriginal"] == nil)
    }
}
