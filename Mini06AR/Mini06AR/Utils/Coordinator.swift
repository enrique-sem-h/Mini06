//
//  Coordinator.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 21/07/24.
//

import UIKit

/**
 O protocolo `Coordinator` define a estrutura básica para um coordinator de navegação.
 Um `Coordinator` é responsável por gerenciar a navegação dentro do aplicativo.
 */
protocol Coordinator: AnyObject {
    /// Lista de coordinators filhos para manter a hierarquia de navegação.
    var childCoordinators: [Coordinator] { get set }
    
    /// Controlador de navegação principal.
    var navigationController: UINavigationController { get set }
    
    /// Método inicial para começar o fluxo do coordinator.
    func start()
}
