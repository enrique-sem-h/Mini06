//
//  ARCoordinator.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 21/07/24.
//

import UIKit

/**
 The `ARCoordinator` class is responsible for managing the navigation flow for the AR view.
 */
class ARCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var planet: Planet
    weak var parentCoordinator: Coordinator?
    
    /**
     Initializes a new `ARCoordinator` with the provided navigation controller and planet.
     
     - Parameters:
        - navigationController: The navigation controller for the app.
        - planet: The planet to be displayed in the AR view.
     */
    init(navigationController: UINavigationController, planet: Planet) {
        self.navigationController = navigationController
        self.planet = planet
    }
    
    /**
     Starts the flow by showing the AR view controller.
     */
    func start() {
        let arViewController = ARViewController()
        arViewController.coordinator = self
        arViewController.planet = planet
        navigationController.pushViewController(arViewController, animated: true)
    }
    
    /**
     Shows the planet detail view.
     */
    func showPlanetDetail() {
            let planetDetailCoordinator = PlanetDetailCoordinator(navigationController: navigationController, planet: planet)
            childCoordinators.append(planetDetailCoordinator)
            planetDetailCoordinator.parentCoordinator = self
            planetDetailCoordinator.start()
        }
    
    /**
     Shows the solar system view.
     */
    func showSolarSystemView() {
        let solarSystemViewController = SolarSystemViewController()
        navigationController.pushViewController(solarSystemViewController, animated: true)
    }
    
    /**
     Indicates that the coordinator has finished its work.
     */
    func didFinish() {
        parentCoordinator?.childCoordinators.removeAll { $0 === self }
    }
}
