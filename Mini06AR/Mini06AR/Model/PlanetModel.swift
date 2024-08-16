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
    let descriptions: [String: String]
    let modelName: String

    /**
     Inicializa uma nova instância de `Planet`.
     
     - Parameters:
        - name: O nome do planeta.
        - descriptions: Um dicionário contendo descrições e curiosidades sobre o planeta.
        - modelName: O nome do arquivo do modelo 3D do planeta.
        - textureName: O nome do arquivo da textura do modelo 3D.
     */
}
