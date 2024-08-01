//
//  Extension+CustomARView.swift
//  Mini06AR
//
//  Created by Fabio Freitas on 26/07/24.
//

import UIKit
import ARKit
import RealityKit

/**
 Esta extensão em `CustomARView` é responsável pelos métodos lidam com os gestures que possuem interação com a Realidade Aumentada
 */
extension CustomARView {
    internal static let defaultModelName = "Earth.usdz"
    
    func enableControls() {
        enablePlanetARTapGestures()
        enablePinchControls()
        enablePlanetRotation()
    }
    
    private func enablePlanetARTapGestures() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handlePlanetARTap))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    private func enablePlanetRotation() {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        self.addGestureRecognizer(recognizer)
    }
    
    private func enablePinchControls() {
        let recognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture))
        self.addGestureRecognizer(recognizer)
    }
    
    @objc private func handlePinchGesture(_ recognizer: UIPinchGestureRecognizer) {
        let value = Float(recognizer.scale)
        
        guard let planet = self.scene.findEntity(named: self.arPlanetViewController?.planet?.modelName ?? Self.defaultModelName) else { return }
        
        planet.stopAllAnimations()
        // Apply the incremental rotation to the entity's current orientation
        planet.scale = SIMD3(x: value, y: value, z: value)
    }
    
    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        // Get the translation in the view's coordinate system
        let translation = recognizer.translation(in: self)
        
        // Define a scale factor for the rotation sensitivity
        let sensitivity: Float = 0.005
        
        // Calculate rotation angles based on the translation
        let angleX = Float(translation.x) * sensitivity
        let angleY = Float(translation.y) * sensitivity
        
        // Define the rotation axes (y-axis for horizontal panning, x-axis for vertical panning)
        let rotationAxisX = simd_float3(0, 1, 0) // Rotation around the y-axis
        let rotationAxisY = simd_float3(1, 0, 0) // Rotation around the x-axis
        
        // Create quaternions for each rotation
        let quatX = simd_quatf(angle: angleX, axis: rotationAxisX)
        let quatY = simd_quatf(angle: angleY, axis: rotationAxisY)
        
        // Combine the rotations
        let combinedQuat = quatX * quatY
        
        // Find the entity
        guard let planet = self.scene.findEntity(named: self.arPlanetViewController?.planet?.modelName ?? Self.defaultModelName) else { return }
        
        planet.stopAllAnimations()
        // Apply the incremental rotation to the entity's current orientation
        planet.orientation = combinedQuat * planet.orientation
        
        // Reset the translation to zero for incremental updates
        recognizer.setTranslation(.zero, in: self)
    }

    
    @objc private func handlePlanetARTap(recognizer: UITapGestureRecognizer) {
        let loc = recognizer.location(in: self)
        guard let rayResult = self.ray(through: loc) else { return }
        let results = self.scene.raycast(origin: rayResult.origin, direction: rayResult.direction)
        
        if let firstResult = results.first {
            if self.scene.findEntity(named: self.arPlanetViewController?.planet?.modelName ?? Self.defaultModelName )?.findEntity(named: firstResult.entity.name) != nil {
                arViewDelegate?.toggleInfo()
            }
            
        } else {
            let results = self.raycast(from: loc, allowing: .estimatedPlane, alignment: .any)
            if let first = results.first {
                let position = simd_make_float3(first.worldTransform.columns.3)
                if self.scene.anchors.first?.findEntity(named: self.arPlanetViewController?.planet?.modelName ?? Self.defaultModelName) != nil {
                    return
                }
                let planetAnchor = AnchorEntity(world: position)
                if let planetModel = try? ModelEntity.load(named: self.arPlanetViewController?.planet?.modelName ?? Self.defaultModelName) {
                    planetModel.name = self.arPlanetViewController?.planet?.modelName ?? Self.defaultModelName
                    planetModel.generateCollisionShapes(recursive: true)
                    planetAnchor.addChild(planetModel)
                    let from = Transform(rotation: .init(angle: .pi * 2, axis: [0, 1, 0]))
                    
                    let definition = FromToByAnimation(from: from,
                                                       duration: 20,
                                                       timing: .linear,
                                                       bindTarget: .transform,
                                                       repeatMode: .repeat)
                    
                    if let animate = try? AnimationResource.generate(with: definition) {
                        planetModel.playAnimation(animate)
                    }
                    self.scene.addAnchor(planetAnchor)
                }
            }
        }
        
    }
}
