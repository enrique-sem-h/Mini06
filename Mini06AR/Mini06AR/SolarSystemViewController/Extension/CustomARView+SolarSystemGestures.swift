//
//  CustomARView+SolarSystemGestures.swift
//  Mini06AR
//
//  Created by Fabio Freitas on 30/07/24.
//

import UIKit
import ARKit
import RealityKit

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
            createOrbitingPlanets(anchor: mainAnchor, planets: SolarSystemARView.planetModelNames)
            
            self.scene.addAnchor(mainAnchor)
            arViewDelegate?.didPlace3DObject()
        }
        
    }
    private func createSun(anchor: AnchorEntity) {
        guard let sun = try? ModelEntity.load(named: SolarSystemARView.sunModel) else { return }
        sun.name = SolarSystemARView.sunModel
        sun.scale = [0.6,0.6,0.6]
        sun.transform.translation.y = anchor.transform.translation.y
        anchor.addChild(sun)
    }
    
    private func createOrbitingPlanets(anchor: AnchorEntity, planets: [String]) {
        for (n,model) in planets.enumerated() {
            guard  let planetEntity = try? ModelEntity.load(named: model) else { return }
            let p = planetEntity.clone(recursive: true)
            let n = n + 1
            p.name = model
            p.scale = [0.5,0.5,0.5] // Size
            p.transform.translation.y = anchor.transform.translation.y
            anchor.addChild(p)
            
            var t = p.transform
            t .translation = [0,0,2.0*Float(n)] // Distance
            if let orbit = Self.createOrbitAnimation(transform: t, n: n){
                p.playAnimation(orbit)
            }
        }
    }
    
    static func createOrbitAnimation(transform: Transform, n: Int?) -> AnimationResource? {
        let baseDuration = 20.0
        let duration = baseDuration * Double(n ?? 1)
        let orbitAnimationDefinition = OrbitAnimation(duration: duration, axis: [0,1,0], startTransform: transform, bindTarget: .transform, repeatMode: .cumulative)
        return try? AnimationResource.generate(with: orbitAnimationDefinition)
    }
}
