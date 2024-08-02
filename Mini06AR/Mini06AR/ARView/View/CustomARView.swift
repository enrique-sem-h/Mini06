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
    func didPlace3DObject()
}

extension CustomARViewDelegate {
    func didPlace3DObject() {}
    func toggleInfo() {}
}

/**
 A classe `CustomARView` constrói uma ARView que possui referências para a ViewController e para um delegate que é responsável por mostrar/esconder as curiosidades.
 */
class CustomARView: ARView {
    var arViewDelegate: CustomARViewDelegate?
    var arPlanetViewController: ARViewController?
}
