//
//  MainCoordinator.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 21/07/24.
//

import UIKit

/**
 A classe `MainCoordinator` é responsável por iniciar e gerenciar o fluxo de navegação principal do aplicativo.
 */
class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    /**
     Inicializa um novo `MainCoordinator` com o controlador de navegação fornecido.
     
     - Parameter navigationController: O controlador de navegação principal para o aplicativo.
     */
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /**
     Inicia o fluxo principal mostrando o controlador de visualização inicial.
     */
    func start() {
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: false)
    }

    /**
     Mostra a visualização AR para o planeta selecionado.
     
     - Parameter planet: O planeta a ser exibido na visualização AR.
     */
    func showARView(for planet: Planet) {
        let arCoordinator = ARCoordinator(navigationController: navigationController, planet: planet)
        childCoordinators.append(arCoordinator)
        arCoordinator.parentCoordinator = self
        arCoordinator.start()
    }
}
