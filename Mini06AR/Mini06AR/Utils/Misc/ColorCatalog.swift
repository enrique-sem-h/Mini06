//
//  ColorCatalog.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 06/08/24.
//

import UIKit

// Extensão para criar uma cor a partir de um valor hexadecimal
extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        
        let red = CGFloat((int >> 16) & 0xFF) / 255.0
        let green = CGFloat((int >> 8) & 0xFF) / 255.0
        let blue = CGFloat(int & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

// Estrutura para armazenar cores com valores hexadecimais
struct ColorCatalog {

    // Valores Hexadecimais
    struct HexValues {
        static let blue = "#304B7A"
        static let yellow = "#DBA451"
        static let orange = "#E06136"
        static let red = "#C82238"
        static let white = "#F4F5F7"
        static let black = "#191919"
        
        static let mercury = "#2B3138"
        static let venus = "#DBBC6E"
        static let earth = "#6E9EDB"
        static let mars = "#DB6E6E"
        static let jupiter = "#DB9C6E"
        static let saturn = "#DBA96E"
        static let uranus = "#6EC1DB"
        static let neptune = "#6E93DB"
        static let moon = "#7C8085"
        static let sun = "#DB886E"
        
        static let mercuryText = "#FFFFFF"
        static let venusText = "#3A372C"
        static let earthText = "#0A0A0A"
        static let marsText = "#390A10"
        static let jupiterText = "#471A0B"
        static let saturnText = "#6E2811"
        static let uranusText = "#2F3979"
        static let neptuneText = "#2F3979"
        static let moonText = "#F4F5F7"
        static let sunText = "#802F14"
        
        static let mercuryDescText = "#FFFFFF"
        static let venusDescText = "#3A372C"
        static let earthDescText = "#0A0A0A"
        static let marsDescText = "#390A10"
        static let jupiterDescText = "#471A0B"
        static let saturnDescText = "#6E2811"
        static let uranusDescText = "#000000"
        static let neptuneDescText = "#000000"
        static let moonDescText = "#030303"
        static let sunDescText = "#000000"
        
        static let mercuryTextBackground = "#333333"
        static let venusTextBackground = "#B29A5A"
        static let earthTextBackground = "#5A81B2"
        static let marsTextBackground = "#B25A5A"
        static let jupiterTextBackground = "#B27F5A"
        static let saturnTextBackground = "#B28A5A"
        static let uranusTextBackground = "#5A9DB2"
        static let neptuneTextBackground = "#5A78B2"
        static let moonTextBackground = "#474A4D"
        static let sunTextBackground = "#B26F5A"
    }

    // Cores Básicas
    static let blue = UIColor(hex: HexValues.blue)
    static let yellow = UIColor(hex: HexValues.yellow)
    static let orange = UIColor(hex: HexValues.orange)
    static let red = UIColor(hex: HexValues.red)
    static let white = UIColor(hex: HexValues.white)
    static let black = UIColor(hex: HexValues.black)

    // Cores Pastel para Planetas
    static let planetaryColors: [String: UIColor] = [
        "Mercury": UIColor(hex: HexValues.mercury),
        "Venus": UIColor(hex: HexValues.venus),
        "Earth": UIColor(hex: HexValues.earth),
        "Mars": UIColor(hex: HexValues.mars),
        "Jupiter": UIColor(hex: HexValues.jupiter),
        "Saturn": UIColor(hex: HexValues.saturn),
        "Uranus": UIColor(hex: HexValues.uranus),
        "Neptune": UIColor(hex: HexValues.neptune),
        "Moon" : UIColor(hex: HexValues.moon),
        "Sun" : UIColor(hex: HexValues.sun)
    ]

    // Cores para o texto dos planetas
    static let textColors: [String: UIColor] = [
        "Mercury": UIColor(hex: HexValues.mercuryText),
        "Venus": UIColor(hex: HexValues.venusText),
        "Earth": UIColor(hex: HexValues.earthText),
        "Mars": UIColor(hex: HexValues.marsText),
        "Jupiter": UIColor(hex: HexValues.jupiterText),
        "Saturn": UIColor(hex: HexValues.saturnText),
        "Uranus": UIColor(hex: HexValues.uranusText),
        "Neptune": UIColor(hex: HexValues.neptuneText),
        "Moon" : UIColor(hex: HexValues.moonText),
        "Sun" : UIColor(hex: HexValues.sunText)
    ]

    // Cores para o texto das descrições dos planetas
    static let descriptionTextColors: [String: UIColor] = [
        "Mercury": UIColor(hex: HexValues.mercuryDescText),
        "Venus": UIColor(hex: HexValues.venusDescText),
        "Earth": UIColor(hex: HexValues.earthDescText),
        "Mars": UIColor(hex: HexValues.marsDescText),
        "Jupiter": UIColor(hex: HexValues.jupiterDescText),
        "Saturn": UIColor(hex: HexValues.saturnDescText),
        "Uranus": UIColor(hex: HexValues.uranusDescText),
        "Neptune": UIColor(hex: HexValues.neptuneDescText),
        "Moon" : UIColor(hex: HexValues.moonDescText),
        "Sun" : UIColor(hex: HexValues.sunDescText)
    ]

    // Cores de fundo para o texto dos planetas
    static let textBackgroundColors: [String: UIColor] = [
        "Mercury": UIColor(hex: HexValues.mercuryTextBackground),
        "Venus": UIColor(hex: HexValues.venusTextBackground),
        "Earth": UIColor(hex: HexValues.earthTextBackground),
        "Mars": UIColor(hex: HexValues.marsTextBackground),
        "Jupiter": UIColor(hex: HexValues.jupiterTextBackground),
        "Saturn": UIColor(hex: HexValues.saturnTextBackground),
        "Uranus": UIColor(hex: HexValues.uranusTextBackground),
        "Neptune": UIColor(hex: HexValues.neptuneTextBackground),
        "Moon" : UIColor(hex: HexValues.moonTextBackground),
        "Sun" : UIColor(hex: HexValues.sunTextBackground)
    ]

    // Métodos para obter cores com base no nome do corpo celeste
    static func getBackgroundColor(for celestialBody: String) -> UIColor {
        return planetaryColors[celestialBody] ?? .white
    }

    static func getTextColor(for celestialBody: String) -> UIColor {
        return textColors[celestialBody] ?? .black
    }
    
    static func getDescriptionTextColor(for celestialBody: String) -> UIColor {
        return descriptionTextColors[celestialBody] ?? .black
    }

    static func getTextBackgroundColor(for celestialBody: String) -> UIColor {
        return textBackgroundColors[celestialBody] ?? .white
    }
}
