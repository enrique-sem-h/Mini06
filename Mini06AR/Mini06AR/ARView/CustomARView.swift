//
//  CustomARView.swift
//  Mini06AR
//
//  Created by Fabio Freitas on 26/07/24.
//
import ARKit
import UIKit
import RealityKit

protocol CustomARViewDelegate {
    func toggleInfo()
}

class CustomARView: ARView {
    var arViewDelegate: CustomARViewDelegate?
    var viewController: ARViewController?
}
