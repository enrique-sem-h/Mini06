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
    static let blue = UIColor(hex: "#304B7A") // Azul
    static let yellow = UIColor(hex: "#DBA451") // Amarelo
    static let orange = UIColor(hex: "#E06136") // Laranja
    static let red = UIColor(hex: "#C82238") // Vermelho
    static let white = UIColor(hex: "#F4F5F7") // Branco
    static let black = UIColor(hex: "191919") // Preto

    // Cores Pastel para Planetas
    static let planetaryColors: [String: UIColor] = [
        "Mercury": UIColor(hex: "#A3A3A3"), // Cinza Pastel
        "Venus": UIColor(hex: "#F3E3B5"), // Amarelo Pastel
        "Earth": UIColor(hex: "#A3B8D3"), // Azul Pastel
        "Mars": UIColor(hex: "#E8A3A3"), // Vermelho Pastel
        "Jupiter": UIColor(hex: "#F3C8A5"), // Laranja Pastel
        "Saturn": UIColor(hex: "#F4D4A2"), // Mistura de Laranja e Amarelo Pastel
        "Uranus": UIColor(hex: "#B5D4E3"), // Azul Claro Pastel
        "Neptune": UIColor(hex: "#A3A3D3") // Azul Escuro Pastel
    ]

    // Cores para o texto dos planetas
    static let textColors: [String: UIColor] = [
        "Mercury": UIColor(hex: "#333333"), // Cinza Escuro
        "Venus": UIColor(hex: "#666666"), // Cinza Médio
        "Earth": UIColor(hex: "#000000"), // Preto
        "Mars": UIColor(hex: "#4D4D4D"), // Cinza Escuro
        "Jupiter": UIColor(hex: "#3D3D3D"), // Cinza Médio
        "Saturn": UIColor(hex: "#4C4C4C"), // Cinza Escuro
        "Uranus": UIColor(hex: "#2C2C2C"), // Preto
        "Neptune": UIColor(hex: "#1A1A1A") // Preto
    ]

    // Cores para o texto das descrições dos planetas
    static let descriptionTextColors: [String: UIColor] = [
        "Mercury": UIColor(hex: "#595959"), // Cinza Médio
        "Venus": UIColor(hex: "#7A7A7A"), // Cinza Claro
        "Earth": UIColor(hex: "#333333"), // Cinza Escuro
        "Mars": UIColor(hex: "#6E6E6E"), // Cinza Médio
        "Jupiter": UIColor(hex: "#4A4A4A"), // Cinza Escuro
        "Saturn": UIColor(hex: "#6B6B6B"), // Cinza Médio
        "Uranus": UIColor(hex: "#4D4D4D"), // Cinza Escuro
        "Neptune": UIColor(hex: "#3A3A3A") // Cinza Escuro
    ]

    // Cores Pastel para Sol e Lua
    static let pastelSun = UIColor(hex: "#F7D9A2") // Amarelo Pastel Claro
    static let pastelMoon = UIColor(hex: "#D3D3D3") // Cinza Pastel
    static let textSun = UIColor(hex: "#2C2C2C") // Preto
    static let textMoon = UIColor(hex: "#4A4A4A") // Cinza Escuro

    // Cores para o texto das descrições do Sol e da Lua
    static let descriptionTextSun = UIColor(hex: "#4A4A4A") // Laranja Claro
    static let descriptionTextMoon = UIColor(hex: "#6E6E6E") // Cinza Médio

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
