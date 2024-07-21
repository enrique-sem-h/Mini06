//
//  MainCoordinator.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 21/07/24.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: false)
    }

    func showARView(for planet: Planet) {
        let arCoordinator = ARCoordinator(navigationController: navigationController, planet: planet)
        childCoordinators.append(arCoordinator)
        arCoordinator.parentCoordinator = self
        arCoordinator.start()
    }
}

