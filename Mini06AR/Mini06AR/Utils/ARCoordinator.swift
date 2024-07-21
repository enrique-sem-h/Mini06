//
//  ARCoordinator.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 21/07/24.
//

import UIKit

class ARCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var planet: Planet
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController, planet: Planet) {
        self.navigationController = navigationController
        self.planet = planet
    }
    
    func start() {
        let arViewController = ARViewController()
        arViewController.coordinator = self
        arViewController.planet = planet
        navigationController.pushViewController(arViewController, animated: true)
    }
    
    func showPlanetDetail() {
        let planetDetailCoordinator = PlanetDetailCoordinator(navigationController: navigationController, planet: planet)
        childCoordinators.append(planetDetailCoordinator)
        planetDetailCoordinator.parentCoordinator = self
        planetDetailCoordinator.start()
    }
    
    func showSolarSystemView() {
        let solarSystemViewController = SolarSystemViewController()
        navigationController.pushViewController(solarSystemViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childCoordinators.removeAll { $0 === self }
    }
}
