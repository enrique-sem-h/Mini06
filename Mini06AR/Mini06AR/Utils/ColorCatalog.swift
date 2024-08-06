//
//  ColorCatalog.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 06/08/24.
//

import UIKit

// Estrutura para armazenar cores com valores hexadecimais
struct ColorCatalog {
    static let blue = UIColor(hex: "#304B7A") // Azul
    static let yellow = UIColor(hex: "#DBA451") // Amarelo
    static let orange = UIColor(hex: "#E06136") // Laranja
    static let red = UIColor(hex: "#C82238") // Vermelho
    static let white = UIColor(hex: "#F4F5F7") // Branco
    static let black = UIColor(hex: "191919") // Preto

    // Cores Pastel para Planetas
    static let pastelMercury = UIColor(hex: "#A3A3A3") // Cinza Pastel
    static let pastelVenus = UIColor(hex: "#F3E3B5") // Amarelo Pastel
    static let pastelEarth = UIColor(hex: "#A3B8D3") // Azul Pastel
    static let pastelMars = UIColor(hex: "#E8A3A3") // Vermelho Pastel
    static let pastelJupiter = UIColor(hex: "#F3C8A5") // Laranja Pastel
    static let pastelSaturn = UIColor(hex: "#F4D4A2") // Mistura de Laranja e Amarelo Pastel
    static let pastelUranus = UIColor(hex: "#B5D4E3") // Azul Claro Pastel
    static let pastelNeptune = UIColor(hex: "#A3A3D3") // Azul Escuro Pastel

    // Cores para o texto dos planetas
    static let textMercury = UIColor(hex: "#333333") // Cinza Escuro
    static let textVenus = UIColor(hex: "#666666") // Cinza Médio
    static let textEarth = UIColor(hex: "#000000") // Preto
    static let textMars = UIColor(hex: "#4D4D4D") // Cinza Escuro
    static let textJupiter = UIColor(hex: "#3D3D3D") // Cinza Médio
    static let textSaturn = UIColor(hex: "#4C4C4C") // Cinza Escuro
    static let textUranus = UIColor(hex: "#2C2C2C") // Preto
    static let textNeptune = UIColor(hex: "#1A1A1A") // Preto

    // Cores Pastel para Sol e Lua
    static let pastelSun = UIColor(hex: "#F7D9A2") // Amarelo Pastel Claro
    static let pastelMoon = UIColor(hex: "#D3D3D3") // Cinza Pastel

    // Método para obter a cor de fundo e a cor do texto com base no nome do planeta
    static func getBackgroundColor(for planetName: String) -> UIColor {
        switch planetName {
        case "Mercury":
            return pastelMercury
        case "Venus":
            return pastelVenus
        case "Earth":
            return pastelEarth
        case "Mars":
            return pastelMars
        case "Jupiter":
            return pastelJupiter
        case "Saturn":
            return pastelSaturn
        case "Uranus":
            return pastelUranus
        case "Neptune":
            return pastelNeptune
        default:
            return .white
        }
    }

    static func getTextColor(for planetName: String) -> UIColor {
        switch planetName {
        case "Mercury":
            return textMercury
        case "Venus":
            return textVenus
        case "Earth":
            return textEarth
        case "Mars":
            return textMars
        case "Jupiter":
            return textJupiter
        case "Saturn":
            return textSaturn
        case "Uranus":
            return textUranus
        case "Neptune":
            return textNeptune
        default:
            return .black
        }
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
