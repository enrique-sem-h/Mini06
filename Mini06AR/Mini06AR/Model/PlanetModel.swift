//
//  PlanetModel.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 19/07/24.
//

import Foundation

/**
 A estrutura `Planet` representa um planeta no aplicativo.
 */
struct Planet {
    let name: String
    let imageName: String
    let radius: Double
    let distanceFromSun: Double
    let descriptions: [String: String]

    /**
     Inicializa uma nova instância de `Planet`.
     
     - Parameters:
        - name: O nome do planeta.
        - imageName: O nome da imagem associada ao planeta.
        - radius: O raio do planeta em quilômetros.
        - distanceFromSun: A distância do planeta ao Sol em milhões de quilômetros.
        - descriptions: Um dicionário contendo descrições e curiosidades sobre o planeta.
     */
    init(name: String, imageName: String, radius: Double, distanceFromSun: Double, descriptions: [String: String]) {
        self.name = name
        self.imageName = imageName
        self.radius = radius
        self.distanceFromSun = distanceFromSun
        self.descriptions = descriptions
    }
}
