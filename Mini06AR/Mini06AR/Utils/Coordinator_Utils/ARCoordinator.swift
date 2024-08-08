//
//  ARCoordinator.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 21/07/24.
//

import UIKit

/**
 A classe `ARCoordinator` é responsável por gerenciar o fluxo de navegação para a visualização AR.
 */
class ARCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var planet: Planet
    weak var parentCoordinator: Coordinator?
    
    /**
     Inicializa um novo `ARCoordinator` com o controlador de navegação e o planeta fornecidos.
     
     - Parameters:
        - navigationController: O controlador de navegação para o aplicativo.
        - planet: O planeta a ser exibido na visualização AR.
     */
    init(navigationController: UINavigationController, planet: Planet) {
        self.navigationController = navigationController
        self.planet = planet
    }
    
    /**
     Inicia o fluxo mostrando o controlador de visualização AR.
     */
    func start() {
        let arViewController = ARViewController()
        arViewController.coordinator = self
        arViewController.planet = planet
        navigationController.pushViewController(arViewController, animated: true)
    }
    
    /**
     Mostra a visualização de detalhes do planeta.
     */
    func showPlanetDetail() {
            let planetDetailCoordinator = PlanetDetailCoordinator(navigationController: navigationController, planet: planet)
            childCoordinators.append(planetDetailCoordinator)
            planetDetailCoordinator.parentCoordinator = self
            planetDetailCoordinator.start()
        }
    
    /**
     Indica que o coordinator terminou seu trabalho.
     */
    func didFinish() {
        parentCoordinator?.childCoordinators.removeAll { $0 === self }
    }
}
