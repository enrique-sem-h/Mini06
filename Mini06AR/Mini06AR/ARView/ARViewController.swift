//
//  ARViewController.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 19/07/24.
//

import UIKit

/**
 A classe `ARViewController` exibe uma visualização AR do planeta selecionado.
 */
class ARViewController: UIViewController {
    var coordinator: ARCoordinator?
    var planet: Planet?

    var planetARView: PlanetARView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetARView = PlanetARView()
        planetARView?.arViewController = self
        
        self.view = planetARView
    }

    @objc func showPlanetDetail() {
        coordinator?.showPlanetDetail()
    }

}
