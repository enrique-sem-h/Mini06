//
//  SolarSystemARView+CustomARViewDelegate.swift
//  Mini06AR
//
//  Created by Fabio Freitas on 31/07/24.
//

import Foundation

extension SolarSystemARView: CustomARViewDelegate {
    func didPlace3DObject() {
        isPlayingAnimation = true
        updateAnimationButtonTitle()
    }
}
