//
//  PlanetDetailCoordinator.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 21/07/24.
//

import UIKit

/**
 A classe `PlanetDetailCoordinator` é responsável por gerenciar o fluxo de navegação para exibir os detalhes de um planeta.
 */
class PlanetDetailCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var planet: Planet
    weak var parentCoordinator: Coordinator?

    init(navigationController: UINavigationController, planet: Planet) {
        self.navigationController = navigationController
        self.planet = planet
    }

    func start() {
        let planetDetailViewController = PlanetDetailViewController()
        planetDetailViewController.planet = planet
        planetDetailViewController.coordinator = self
        navigationController.pushViewController(planetDetailViewController, animated: true)
    }

    func didFinish() {
        parentCoordinator?.childCoordinators.removeAll { $0 === self }
    }
}
