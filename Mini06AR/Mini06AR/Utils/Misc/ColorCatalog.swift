//
//  ColorCatalog.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 06/08/24.
//

import UIKit

// Estrutura para armazenar cores com valores hexadecimais
struct ColorCatalog {

    // Cores Básicas
    static let blue = UIColor(hex: "#304B7A")
    static let yellow = UIColor(hex: "#DBA451")
    static let orange = UIColor(hex: "#E06136")
    static let red = UIColor(hex: "#C82238")
    static let white = UIColor(hex: "#F4F5F7")
    static let black = UIColor(hex: "191919")

    // Cores Pastel para Planetas
    static let planetaryColors: [String: UIColor] = [
        "Mercury": UIColor(hex: "#666666"),
        "Venus": UIColor(hex: "#F3E3B5"),
        "Earth": UIColor(hex: "#A3B8D3"),
        "Mars": UIColor(hex: "#E8A3A3"),
        "Jupiter": UIColor(hex: "#F3C8A5"),
        "Saturn": UIColor(hex: "#FCEDD4"),
        "Uranus": UIColor(hex: "#B5D4E3"),
        "Neptune": UIColor(hex: "#8DADFF"),
        "Moon" : UIColor(hex: "BBBBBB"),
        "Sun" : UIColor(hex: "FFDE80")
    ]

    // Cores para o texto dos planetas
    static let textColors: [String: UIColor] = [
        "Mercury": UIColor(hex: "#FFFFFF"),
        "Venus": UIColor(hex: "#B0411C"),
        "Earth": UIColor(hex: "#FFFFFF"),
        "Mars": UIColor(hex: "#FFFFFF"),
        "Jupiter": UIColor(hex: "#923517"),
        "Saturn": UIColor(hex: "#B9441D"),
        "Uranus": UIColor(hex: "#2F3979"),
        "Neptune": UIColor(hex: "#1A1A1A"),
        "Moon" : UIColor(hex: "2F3979"),
        "Sun" : UIColor(hex: "2F3979")

    ]

    // Cores para o texto das descrições dos planetas
    static let descriptionTextColors: [String: UIColor] = [
        "Mercury": UIColor(hex: "#FFFFFF"),
        "Venus": UIColor(hex: "#304B7A"),
        "Earth": UIColor(hex: "#FFFFFF"),
        "Mars": UIColor(hex: "#FFFFFF"),
        "Jupiter": UIColor(hex: "#471A0B"),
        "Saturn": UIColor(hex: "#6E2811"),
        "Uranus": UIColor(hex: "#000000"),
        "Neptune": UIColor(hex: "#000000"),
        "Moon" : UIColor(hex: "000000"),
        "Sun" : UIColor(hex: "000000")

    ]

    // Cores de fundo para o texto dos planetas
    static let textBackgroundColors: [String: UIColor] = [
        "Mercury": UIColor(hex: "#333333"),
        "Venus": UIColor(hex: "#FFDE81"),
        "Earth": UIColor(hex: "#233955"),
        "Mars": UIColor(hex: "#BB4F4F"),
        "Jupiter": UIColor(hex: "#EBA165"),
        "Saturn": UIColor(hex: "#FFDEA6"),
        "Uranus": UIColor(hex: "#71ABC7"),
        "Neptune": UIColor(hex: "#5D72A8"),
        "Moon" : UIColor(hex: "#888888"),
        "Sun" : UIColor(hex: "#FFCB37")
    ]

    // Método para obter a cor de fundo com base no nome do corpo celeste
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
