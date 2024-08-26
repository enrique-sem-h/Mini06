//
//  ARViewController.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 19/07/24.
//

import UIKit
import ARKit

/**
 A classe `ARViewController` exibe uma visualização AR do planeta selecionado.
 */
class ARViewController: UIViewController {
    var coordinator: ARCoordinator?
    var planet: Planet?
    
    var arHudView: ARHUDView?
    var planetARView: PlanetARView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arHudView = ARHUDView(self)
        
        if planet != nil {
            planetARView = PlanetARView(viewController: self)
        }
        
        if let arHudView, let planetARView {
            view.addSubview(planetARView)
            view.addSubview(arHudView)
            
        }
        
    }
    
    @objc func showPlanetDetail() {
        coordinator?.showPlanetDetail()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let planetARView, planetARView.isShowingInfo {
            planetARView.toggleInfo()
        }
        planetARView?.arView.scene.anchors.removeAll()
    }
    
}
