//
//  ViewController.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 19/07/24.
//

import UIKit

class HomeViewController: UIViewController {
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inicialize a HomeView com o frame e a lista de planetas
        let homeView = HomeView(frame: self.view.bounds, planets: planets)
        self.view.addSubview(homeView)
        
        // Configurar coordenador para navegação
        homeView.showARView = { [weak self] planet in
            self?.coordinator?.showARView(for: planet)
        }
    }
}

