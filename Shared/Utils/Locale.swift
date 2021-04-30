//
//  Locale.swift
//  CurRates
//
//  Created by Maksim Kalik on 4/30/21.
//

import Foundation

extension Locale {
    
    enum Language: String {
        case LV
        case EN
        case RU
        case LT
        case DE
    }
    
    private func preferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
    
    private func switchLanguage(code: String?) -> Language {
        switch code?.lowercased() {
        case "en", "us":
            return .EN
        case "lv":
            return .LV
        case "ru":
            return .RU
        default:
            return .EN
        }
    }
    
    var language: Language {
        return switchLanguage(code: preferredLocale().languageCode)
    }
    
    var location: Language {
        return switchLanguage(code: preferredLocale().regionCode)
    }
}
