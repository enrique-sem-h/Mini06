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

    /**
     Initializes a new `PlanetDetailCoordinator` with the provided navigation controller and planet.
     
     - Parameters:
        - navigationController: The navigation controller for the app.
        - planet: The planet whose details will be displayed.
     */
    init(navigationController: UINavigationController, planet: Planet) {
        self.navigationController = navigationController
        self.planet = planet
    }

    /**
     Starts the flow by showing the planet detail view controller.
     */
    func start() {
        let planetDetailViewController = PlanetDetailViewController()
        planetDetailViewController.coordinator = self
        planetDetailViewController.planet = planet
        navigationController.pushViewController(planetDetailViewController, animated: true)
    }

    /**
     Indicates that the coordinator has finished its work.
     */
    func didFinish() {
        parentCoordinator?.childCoordinators.removeAll { $0 === self }
    }
}
