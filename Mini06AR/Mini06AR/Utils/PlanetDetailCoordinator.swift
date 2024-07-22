//
//  PlanetDetailCoordinator.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 21/07/24.
//

import UIKit

/**
 The `PlanetDetailCoordinator` class is responsible for managing the navigation flow for displaying the details of a planet.
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
