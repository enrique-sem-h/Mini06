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
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSolarSystemTap))
        self.addGestureRecognizer(gestureRecognizer)
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
