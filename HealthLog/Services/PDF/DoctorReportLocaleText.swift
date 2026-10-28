import Foundation

// MARK: - Locale text (DE/EN/NL)

/// The doctor report's fixed labels, one branch per `ReportLocale` (split
/// from `DoctorReportSectionDrawer.swift` for the file-length budget when
/// Dutch became the third report language).
enum LocaleText {
    static func coverTitle(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Arztbericht"
        case .en: "Doctor Report"
        case .nl: "Artsenrapport"
        }
    }

    static func coverPatientLabel(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Patient"
        case .en: "Patient"
        case .nl: "Patiënt"
        }
    }

    static func coverFullNameLabel(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Voller Name"
        case .en: "Full name"
        case .nl: "Volledige naam"
        }
    }

    static func coverInsurerLabel(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Krankenkasse"
        case .en: "Health insurer"
        case .nl: "Zorgverzekeraar"
        }
    }

    static func coverInsuranceNumberLabel(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Versicherungsnummer"
        case .en: "Insurance number"
        case .nl: "Verzekeringsnummer"
        }
    }

    static func coverPeriodLabel(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Berichtszeitraum"
        case .en: "Report period"
        case .nl: "Rapportageperiode"
        }
    }

    static func coverGeneratedLabel(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Erstellt am"
        case .en: "Generated"
        case .nl: "Aangemaakt op"
        }
    }

    static func coverVersionLabel(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "App-Version"
        case .en: "App version"
        case .nl: "App-versie"
        }
    }

    static func vitalsTitle(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Vitalwerte"
        case .en: "Vital signs"
        case .nl: "Vitale waarden"
        }
    }

    static func colKind(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Metrik"
        case .en: "Metric"
        case .nl: "Meetwaarde"
        }
    }

    static func colCount(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Anzahl"
        case .en: "Count"
        case .nl: "Aantal"
        }
    }

    static func colMean(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Mittelwert"
        case .en: "Mean"
        case .nl: "Gemiddelde"
        }
    }

    static func colMedian(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Median"
        case .en: "Median"
        case .nl: "Mediaan"
        }
    }

    static func colMin(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Min"
        case .en: "Min"
        case .nl: "Min"
        }
    }

    static func colMax(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Max"
        case .en: "Max"
        case .nl: "Max"
        }
    }

    static func chartsTitle(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Verlauf"
        case .en: "Charts"
        case .nl: "Verloop"
        }
    }

    static func dataPoints(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Datenpunkte"
        case .en: "data points"
        case .nl: "datapunten"
        }
    }

    static func medicationsTitle(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Medikamente"
        case .en: "Medications"
        case .nl: "Medicatie"
        }
    }

    static func medicationsArchived(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Frueher genommen"
        case .en: "Previously taken"
        case .nl: "Eerder gebruikt"
        }
    }

    static func adherenceTitle(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Einnahmetreue"
        case .en: "Adherence"
        case .nl: "Therapietrouw"
        }
    }

    static func moodTitle(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Stimmung"
        case .en: "Mood"
        case .nl: "Stemming"
        }
    }

    static func moodSummaryFormat(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "%d Eintraege, Durchschnitt %.1f / 5"
        case .en: "%d entries, average %.1f / 5"
        case .nl: "%d registraties, gemiddeld %.1f / 5"
        }
    }

    static func moodTagsLabel(for locale: ReportLocale) -> String {
        switch locale {
        case .de: "Haeufigste Tags"
        case .en: "Dominant tags"
        case .nl: "Meest gebruikte tags"
        }
    }
}
