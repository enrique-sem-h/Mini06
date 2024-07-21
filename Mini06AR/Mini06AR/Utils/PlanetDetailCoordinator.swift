//
//  PlanetDetailCoordinator.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 21/07/24.
//

import UIKit

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
        planetDetailViewController.coordinator = self
        planetDetailViewController.planet = planet
        navigationController.pushViewController(planetDetailViewController, animated: true)
    }

    func didFinish() {
        parentCoordinator?.childCoordinators.removeAll { $0 === self }
    }
}
