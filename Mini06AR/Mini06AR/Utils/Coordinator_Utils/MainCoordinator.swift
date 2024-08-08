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
        self.navigationController.isNavigationBarHidden = true
    }

    /**
     Inicia o fluxo principal mostrando o controlador de visualização inicial.
     */
    func start() {
        let initialViewController = InitialViewController()
        initialViewController.coordinator = self
        navigationController.pushViewController(initialViewController, animated: false)
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
    
    /**
     Mostra a visualização do sistema solar.
     */
    func showSolarSystemView() {
        let solarSystemViewController = SolarSystemViewController(coordinator: self)
        navigationController.pushViewController(solarSystemViewController, animated: true)
    }
    
    /**
     Mostra a visualização da Home com animação de fade.
     */
    func showHomeView() {
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self

        // Cria uma view temporária para a transição
        let transitionView = UIView(frame: navigationController.view.bounds)
        transitionView.backgroundColor = UIColor.black
        transitionView.alpha = 0
        navigationController.view.addSubview(transitionView)

        // Anima o fade out da view atual
        UIView.animate(withDuration: 0.5, animations: {
            transitionView.alpha = 1
        }) { _ in
            // Após o fade out, realiza a transição para a nova tela
            self.navigationController.pushViewController(homeViewController, animated: false)
            
            // Anima o fade in
            UIView.animate(withDuration: 0.5, animations: {
                transitionView.alpha = 0
            }) { _ in
                // Remove a view de transição após o fade in
                transitionView.removeFromSuperview()
            }
        }
    }}
