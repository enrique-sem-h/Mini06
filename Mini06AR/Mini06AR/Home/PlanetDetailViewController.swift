//
//  PlanetDetailViewController.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 19/07/24.
//

import UIKit

/**
 A classe `PlanetDetailViewController` exibe os detalhes de um planeta específico.
 */
class PlanetDetailViewController: UIViewController {
    var coordinator: PlanetDetailCoordinator?
    
    var planet: Planet?
    var planetDetailView: PlanetDetailView?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if let planet = self.planet{
            planetDetailView = PlanetDetailView(planet: planet)
        }
        
        self.view.backgroundColor = .systemBackground
        
        self.view = planetDetailView
        setupBackButton()
    }
    
    private func setupBackButton() {
        guard let coordinator = coordinator else { return }
        lazy var backButton = BackButton(coordinator: coordinator)
        view.addSubview(backButton)
        backButton.setupRelatedToView(view: view)
    }
    
}
