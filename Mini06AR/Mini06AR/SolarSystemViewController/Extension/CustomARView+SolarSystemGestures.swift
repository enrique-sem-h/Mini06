//
//  CustomARView+SolarSystemGestures.swift
//  Mini06AR
//
//  Created by Fabio Freitas on 30/07/24.
//

import UIKit
import ARKit
import RealityKit

/**
 Esta extensão em `CustomARView` é responsável pelos métodos lidam com os gestures que possuem interação com a Realidade Aumentada relativos à view do Sistema Solar
 */
extension CustomARView {
    func enableSolarSystemGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSolarSystemTap))
        self.addGestureRecognizer(tapGestureRecognizer)
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handleSolarSystemPinchGesture))
        self.addGestureRecognizer(pinchGestureRecognizer)
    }
    private static var originalPlanetScale: [String:SIMD3<Float>] = [:]
    @objc private func handleSolarSystemPinchGesture(_ recognizer: UIPinchGestureRecognizer) {
        let value = Float(recognizer.scale)
        //stop anim
        arViewDelegate?.toggleAnimations()
        let pinchScale = SIMD3(value, value, value)
        if let sun = self.scene.findEntity(named: SolarSystemARView.sunModel) {
            scaleSun(sun, pinchScale: pinchScale, minimunScaleFactor: 0.25, maximumScaleFactor: 1.25)
        }
        
        for planetName in SolarSystem.solarSystemPlanets.map({$0.modelName}) {
            if let model = self.scene.findEntity(named: planetName) {
                scalePlanet(model, planetName: planetName, pinchScale: pinchScale , minimumScaleFactor: 0.25, maximumScaleFactor: 2.5)
            }
        }
        //start anim
        arViewDelegate?.toggleAnimations()
    }
    
    private func scaleSun(_ sun: Entity, pinchScale: SIMD3<Float>, minimunScaleFactor: Float, maximumScaleFactor: Float) {
        if Self.originalPlanetScale[SolarSystemARView.sunModel] == nil {
            Self.originalPlanetScale[SolarSystemARView.sunModel] = sun.scale
        }
        guard let originalScale = Self.originalPlanetScale[SolarSystemARView.sunModel] else { return }
        let mininumSunScale = originalScale * minimunScaleFactor
        let maxScale = originalScale * maximumScaleFactor
        let newScale = originalScale * pinchScale
        if lessThanSIMD3(newScale, mininumSunScale) {
            sun.scale = originalScale
        } else if greaterThanSIMD3(newScale, maxScale) {
            sun.scale = maxScale
        } else {
            sun.scale = newScale
        }
    }
    
    private func scalePlanet(_ planetEntity: Entity, planetName: String, pinchScale: SIMD3<Float>, minimumScaleFactor: Float, maximumScaleFactor: Float) {
        if Self.originalPlanetScale[planetName] == nil {
            Self.originalPlanetScale[planetName] = planetEntity.scale
        }
        guard let originalScale = Self.originalPlanetScale[planetName] else { return }
        
        let mininumSunScale = originalScale * minimumScaleFactor
        let maxScale = originalScale * maximumScaleFactor
        let newScale = originalScale * pinchScale
        if lessThanSIMD3(newScale, originalScale) {
            planetEntity.scale = originalScale
        } else if greaterThanSIMD3(newScale, maxScale) {
            planetEntity.scale = maxScale
        } else {
            planetEntity.scale = newScale
        }
    }
    
    @objc private func handleSolarSystemTap(recognizer: UITapGestureRecognizer) {
        let loc = recognizer.location(in: self)
        guard let rayResult = self.ray(through: loc) else { return }
        let results = self.scene.raycast(origin: rayResult.origin, direction: rayResult.direction)
        guard results.isEmpty else { return }
        let planeResults = self.raycast(from: loc, allowing: .estimatedPlane, alignment: .any)
        
        if let first = planeResults.first {
            if self.scene.findEntity(named: SolarSystemARView.sunModel) != nil {
                return
            }
            let position = simd_make_float3(first.worldTransform.columns.3)
            let mainAnchor = AnchorEntity(world: position)
            createSun(anchor: mainAnchor)
            createOrbitingPlanets(anchor: mainAnchor, planets: SolarSystem.solarSystemPlanets)
            
            self.scene.addAnchor(mainAnchor)
            arViewDelegate?.didPlace3DObject()
        }
        
    }
    private func createSun(anchor: AnchorEntity) {
        guard let sun = try? ModelEntity.load(named: SolarSystemARView.sunModel) else { return }
        sun.name = SolarSystemARView.sunModel
        sun.scale = [SolarSystem.SolarSystemPlanetModel.sunSize,SolarSystem.SolarSystemPlanetModel.sunSize,SolarSystem.SolarSystemPlanetModel.sunSize]
        sun.transform.translation.y = anchor.transform.translation.y
        anchor.addChild(sun)
    }
    
    private func createOrbitingPlanets(anchor: AnchorEntity, planets: [SolarSystem.SolarSystemPlanetModel]) {
        for (n,planet) in planets.enumerated() {
            guard  let planetEntity = try? ModelEntity.load(named: planet.modelName) else { return }
            let p = planetEntity.clone(recursive: true)
            let n = n + 1
            p.name = planet.modelName
            let planetSize = SolarSystem.SolarSystemPlanetModel.sunSize * planet.scaleRelativeToSun
            p.scale = [planetSize,planetSize,planetSize] // Size
            p.transform.translation.y = anchor.transform.translation.y
            anchor.addChild(p)
            
            var t = p.transform
            t .translation = [0,0,SolarSystem.SolarSystemPlanetModel.distanceToFurthest*planet.distanceRelativeToFurthest] // Distance
            if let orbit = Self.createOrbitAnimation(transform: t, n: n){
                p.playAnimation(orbit)
            }
        }
    }
    
    static func createOrbitAnimation(transform: Transform, n: Int?) -> AnimationResource? {
        let baseDuration = 10.0
        let duration = baseDuration * Double(n ?? 1)
        let orbitAnimationDefinition = OrbitAnimation(duration: duration, axis: [0,1,0], startTransform: transform, bindTarget: .transform, repeatMode: .cumulative)
        return try? AnimationResource.generate(with: orbitAnimationDefinition)
    }
}

fileprivate func lessThanSIMD3(_ vector1: SIMD3<Float>, _ vector2: SIMD3<Float>) -> Bool {
    return vector1.x < vector2.x && vector1.y < vector2.y && vector1.z < vector2.z
}

fileprivate func greaterThanSIMD3(_ vector1: SIMD3<Float>, _ vector2: SIMD3<Float>) -> Bool {
    return vector1.x > vector2.x && vector1.y > vector2.y && vector1.z > vector2.z
}
