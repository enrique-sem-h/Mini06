//
//  ViewController.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 19/07/24.
//

import UIKit
import SceneKit

/**
 A classe `HomeViewController` é um controlador de visualização que gerencia a visualização principal do aplicativo Mini06AR.
 */
class HomeViewController: UIViewController {
    
    /// O coordinator principal que gerencia a navegação.
    var coordinator: MainCoordinator?
    
    var homeView: HomeView!
    
    private let bottomSheetTransitioningDelegate = BottomSheetTransitioningDelegate()

    
    /**
     Chamado após a visualização do controlador ser carregada na memória.
     Configura a `HomeView` e define a ação a ser realizada quando um planeta é selecionado.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView = HomeView(frame: self.view.bounds, planets: planets)
        homeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(planetTouch)))
        homeView.informationButton.addTarget(self, action: #selector(showBottomSheet), for: .touchUpInside)
        self.view.addSubview(homeView)
        
        
        homeView.planetBoxView.showPlanetDetailView = { [weak self] planet in
            self?.coordinator?.showPlanetDetail(for: planet)
        }
        
        
        
        homeView.showARViewController = { [weak self] in
                  self?.coordinator?.showSolarSystemView()
              }



    }
    
    @objc private func showBottomSheet() {
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.modalPresentationStyle = .custom
        bottomSheetVC.transitioningDelegate = bottomSheetTransitioningDelegate
        present(bottomSheetVC, animated: true, completion: nil)
    }
    
    @objc private func planetTouch(recognizer: UITapGestureRecognizer) {
        let loc = recognizer.location(in: homeView)
        
        let hitResults = homeView.sceneView.hitTest(loc, options: nil)
        
        if let rootNode = homeView.sceneView.scene?.rootNode {
            for hitResult in hitResults {
                if isDescendant(of: rootNode, node: hitResult.node) {
                    focusCameraOnNode(hitResult.node)
                    
                    break
                }
            }
        }
    }
    
    private func focusCameraOnNode(_ node: SCNNode) {
        guard let cameraNode = homeView.sceneView.pointOfView else { return }

        let (min, max) = node.boundingBox
        let center = SCNVector3(
            (min.x + max.x) / 2,
            (min.y + max.y) / 2,
            (min.z + max.z) / 2
        )

        let worldCenter = node.convertPosition(center, to: nil)

        let distance: Float = 5
        let direction = SCNVector3(0, 0, distance)
        let cameraPosition = addVectors(left: worldCenter, right: direction)

        SCNTransaction.begin()
        SCNTransaction.animationDuration = 1
        cameraNode.position = cameraPosition
        
        let lookAtNodeConstraint = SCNLookAtConstraint(target: node)
        cameraNode.constraints = [lookAtNodeConstraint]
        
        
        SCNTransaction.commit()
    }

    func addVectors(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3(left.x + right.x, left.y + right.y, left.z + right.z)
    }

    
    private func isDescendant(of rootNode: SCNNode, node: SCNNode) -> Bool {
        var currentNode: SCNNode? = node
        while currentNode != nil {
            if currentNode == rootNode {
                return true
            }
            currentNode = currentNode?.parent
        }
        return false
    }
}

