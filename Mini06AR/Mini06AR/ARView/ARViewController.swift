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
    var planetARView: ARV?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arHudView = ARHUDView(self)
        
        if planet != nil {
            planetARView = ARV(viewController: self)
        }
        
        if let arHudView, let planetARView {
            view.addSubview(planetARView)
            view.addSubview(arHudView)

        }
    }

    @objc func showPlanetDetail() {
        coordinator?.showPlanetDetail()
    }

}
