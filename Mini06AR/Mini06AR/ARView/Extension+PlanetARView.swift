//
//  Extension+PlanetARView.swift
//  Mini06AR
//
//  Created by Fabio Freitas on 26/07/24.
//

import UIKit
import ARKit
import RealityKit

extension PlanetARView {
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        arView.scene.findEntity(named: arView.viewController?.planet?.modelName ?? CustomARView.defaultModelName )?.removeFromParent()
    }
}

extension PlanetARView: CustomARViewDelegate {
    func toggleInfo() {
        if isShowingInfo {
            UIView.animate(withDuration: 0.2, animations: {
                self.infoView.transform = CGAffineTransform(translationX: 0, y: self.infoView.frame.height)
                self.infoView.alpha = 0
            }) { _ in
                self.infoView.removeFromSuperview()
                self.isShowingInfo = false
            }
        } else {
            isShowingInfo = true
            contentView.addSubview(infoView)
            NSLayoutConstraint.activate([
                infoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                infoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                infoView.heightAnchor.constraint(equalToConstant: 100),
                infoView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.35),
                textLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
                textLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
                textLabel.widthAnchor.constraint(equalTo: infoView.widthAnchor, constant: -25),
                textLabel.heightAnchor.constraint(equalTo: infoView.heightAnchor, constant: -25)
            ])
            contentView.layoutIfNeeded()
            infoView.transform = CGAffineTransform(translationX: 0, y: infoView.frame.height)
            UIView.animate(withDuration: 0.2) {
                self.infoView.transform = .identity
                self.infoView.alpha = 1
            }
        }
    }
}

