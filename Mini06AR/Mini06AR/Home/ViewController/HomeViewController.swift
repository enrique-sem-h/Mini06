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
    
    /**
     Chamado após a visualização do controlador ser carregada na memória.
     Configura a `HomeView` e define a ação a ser realizada quando um planeta é selecionado.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cria uma nova HomeView com os limites da tela atual e uma lista de planetas.
        homeView = HomeView(frame: self.view.bounds, planets: planets)
        self.view.addSubview(homeView)
        
        // Define a ação a ser realizada quando um planeta é selecionado.
        homeView.showARView = { [weak self] planet in
            self?.coordinator?.showARView(for: planet)
        }
    }
}
