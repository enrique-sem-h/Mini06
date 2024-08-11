//
//  SolarSystemPlanetModel.swift
//  Mini06AR
//
//  Created by Fabio Freitas on 01/08/24.
//

import Foundation

/**
 A enumeração `SolarSystem` encapsula modelos e dados associados ao sistema solar para o projeto `Mini06AR`.
 */
enum SolarSystem {}

/**
 A extensão `SolarSystem` contém a estrutura `SolarSystemPlanetModel` e uma lista de modelos de planetas para o sistema solar.
 */
extension SolarSystem {
    
    /**
     A estrutura `SolarSystemPlanetModel` representa um planeta no sistema solar.
     
     - Parameters:
       - modelName: O nome do arquivo do modelo 3D (usdz) do planeta.
       - scaleRelativeToSun: O fator de escala do planeta em relação ao tamanho do Sol.
       - distanceRelativeToFurthest: A distância do planeta em relação ao planeta mais distante no sistema solar, normalizada em relação ao valor `distanceToFurthest`.
     */
    public struct SolarSystemPlanetModel {
        let modelName: String
        let scaleRelativeToSun: Float
        let distanceRelativeToFurthest: Float
        
        /**
         O tamanho padrão do Sol em relação aos planetas no sistema solar.
         */
        static let sunSize: Float = 0.6
        
        /**
         A distância padrão para o planeta mais distante no sistema solar, usada como referência para normalização.
         */
        static let distanceToFurthest: Float = 12.0
    }
    
    /**
     Uma lista estática de `SolarSystemPlanetModel` representando os planetas do sistema solar.
     
     Cada planeta é inicializado com o nome do modelo, escala relativa ao Sol, e distância relativa ao planeta mais distante.
     */
    public static let solarSystemPlanets: [SolarSystemPlanetModel] = [
        .init(modelName: "mercury.usdz", scaleRelativeToSun: 0.16, distanceRelativeToFurthest: 0.11),
        .init(modelName: "venus.usdz", scaleRelativeToSun: 0.32, distanceRelativeToFurthest: 0.2),
        .init(modelName: "earth.usdz", scaleRelativeToSun: 0.33, distanceRelativeToFurthest: 0.26),
        .init(modelName: "mars.usdz", scaleRelativeToSun: 0.18, distanceRelativeToFurthest: 0.38),
        .init(modelName: "jupiter.usdz", scaleRelativeToSun: 0.84, distanceRelativeToFurthest: 0.53),
        .init(modelName: "saturn.usdz", scaleRelativeToSun: 0.67, distanceRelativeToFurthest: 0.69),
        .init(modelName: "uranus.usdz", scaleRelativeToSun: 0.5, distanceRelativeToFurthest: 0.84),
        .init(modelName: "neptune.usdz", scaleRelativeToSun: 0.5, distanceRelativeToFurthest: 1.0)
    ]
}
