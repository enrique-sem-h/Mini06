//
//  SolarSystemPlanetModel.swift
//  Mini06AR
//
//  Created by Fabio Freitas on 01/08/24.
//

import Foundation

enum SolarSystem {}

extension SolarSystem {
    public struct SolarSystemPlanetModel {
        let modelName: String
        let scaleRelativeToSun: Float
        let distanceRelativeToFurthest: Float
        
        static let sunSize: Float = 0.6
        static let distanceToFurthest: Float = 12.0
    }
    
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
