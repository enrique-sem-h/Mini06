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
 Esta extensão em `CustomARView` é responsável pelos métodos lidam com os gestures que possuem interação com a Realidade Aumentada do Planeta Selecionado
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
        // Calculate the new scale
           let currentScale = planet.scale
           let scaleFactor = Float(recognizer.scale)
           let newScale = SIMD3<Float>(repeating: scaleFactor) * currentScale

           // Optional: Clamp the new scale to prevent the object from getting too small or large
           let minScale: Float = 0.1
           let maxScale: Float = 2.5
           planet.scale = SIMD3<Float>(
               x: max(min(newScale.x, maxScale), minScale),
               y: max(min(newScale.y, maxScale), minScale),
               z: max(min(newScale.z, maxScale), minScale)
           )
    }
    
    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        // Get the translation in the view's coordinate system
        let translation = recognizer.translation(in: self)
        let combinedQuat = calculateCombinedRotation(translation)
        
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
