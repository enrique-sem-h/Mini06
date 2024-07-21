//
//  MainCoordinator.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 21/07/24.
//

import UIKit

/**
 The `MainCoordinator` class is responsible for starting and managing the main navigation flow of the app.
 */
class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    /**
     Initializes a new `MainCoordinator` with the provided navigation controller.
     
     - Parameter navigationController: The main navigation controller for the app.
     */
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /**
     Starts the main flow by showing the home view controller.
     */
    func start() {
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: false)
    }

    /**
     Shows the AR view for the selected planet.
     
     - Parameter planet: The planet to display in the AR view.
     */
    func showARView(for planet: Planet) {
        let arCoordinator = ARCoordinator(navigationController: navigationController, planet: planet)
        childCoordinators.append(arCoordinator)
        arCoordinator.parentCoordinator = self
        arCoordinator.start()
    }
}
