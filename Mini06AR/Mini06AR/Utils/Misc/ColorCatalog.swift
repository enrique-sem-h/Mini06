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
        
        static let mercury = "#666666"
        static let venus = "#F3E3B5"
        static let earth = "#A3B8D3"
        static let mars = "#E8A3A3"
        static let jupiter = "#F3C8A5"
        static let saturn = "#FCEDD4"
        static let uranus = "#B5D4E3"
        static let neptune = "#8DADFF"
        static let moon = "#BBBBBB"
        static let sun = "#FFDE80"
        
        static let mercuryText = "#FFFFFF"
        static let venusText = "#B0411C"
        static let earthText = "#FFFFFF"
        static let marsText = "#FFFFFF"
        static let jupiterText = "#923517"
        static let saturnText = "#B9441D"
        static let uranusText = "#2F3979"
        static let neptuneText = "#1A1A1A"
        static let moonText = "#2F3979"
        static let sunText = "#2F3979"
        
        static let mercuryDescText = "#FFFFFF"
        static let venusDescText = "#304B7A"
        static let earthDescText = "#FFFFFF"
        static let marsDescText = "#FFFFFF"
        static let jupiterDescText = "#471A0B"
        static let saturnDescText = "#6E2811"
        static let uranusDescText = "#000000"
        static let neptuneDescText = "#000000"
        static let moonDescText = "#000000"
        static let sunDescText = "#000000"
        
        static let mercuryTextBackground = "#333333"
        static let venusTextBackground = "#FFDE81"
        static let earthTextBackground = "#233955"
        static let marsTextBackground = "#BB4F4F"
        static let jupiterTextBackground = "#EBA165"
        static let saturnTextBackground = "#FFDEA6"
        static let uranusTextBackground = "#71ABC7"
        static let neptuneTextBackground = "#5D72A8"
        static let moonTextBackground = "#888888"
        static let sunTextBackground = "#FFCB37"
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
