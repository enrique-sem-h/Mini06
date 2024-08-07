//
//  SolarSystemARView+CustomARViewDelegate.swift
//  Mini06AR
//
//  Created by Fabio Freitas on 31/07/24.
//

import Foundation

/**
 Esta extensão em `SolarSystemARView` é responsável por implementar o método `didPlace3DObject` de `CustomARViewDelegate` que notifica a view quando um objeto é colocado dentro da ARView
 */
extension SolarSystemARView: CustomARViewDelegate {
    func didPlace3DObject() {
        isPlayingAnimation = true
    }
    
    func toggleAnimations() {
        togglePlanetAnimations()
    }
}
