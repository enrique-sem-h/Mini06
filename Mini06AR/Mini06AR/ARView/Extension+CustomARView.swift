//
//  Extension+CustomARView.swift
//  Mini06AR
//
//  Created by Fabio Freitas on 26/07/24.
//

import UIKit
import ARKit
import RealityKit

extension CustomARView {
    internal static let defaultModelName = "Earth.usdz"
    
    func enableTapGesture() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleARViewTap))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func handleARViewTap(recognizer: UITapGestureRecognizer) {
        let loc = recognizer.location(in: self)
        guard let rayResult = self.ray(through: loc) else { return }
        let results = self.scene.raycast(origin: rayResult.origin, direction: rayResult.direction)
        
        if let firstResult = results.first {
            if self.scene.findEntity(named: self.viewController?.planet?.modelName ?? Self.defaultModelName )?.findEntity(named: firstResult.entity.name) != nil {
                arViewDelegate?.toggleInfo()
            }
            
        } else {
            let results = self.raycast(from: loc, allowing: .estimatedPlane, alignment: .any)
            if let first = results.first {
                let position = simd_make_float3(first.worldTransform.columns.3)
                if self.scene.anchors.first?.findEntity(named: self.viewController?.planet?.modelName ?? Self.defaultModelName) != nil {
                    return
                }
                let planetAnchor = AnchorEntity(world: position)
                if let planetModel = try? ModelEntity.load(named: self.viewController?.planet?.modelName ?? Self.defaultModelName) {
                    planetModel.name = self.viewController?.planet?.modelName ?? Self.defaultModelName
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
