//
//  Coordinator.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 21/07/24.
//

import UIKit

/**
 O protocolo `Coordinator` define a estrutura básica para um coordenador de navegação.
 Um `Coordinator` é responsável por gerenciar a navegação dentro do aplicativo.
 */
protocol Coordinator: AnyObject {
    /// Lista de coordenadores filhos para manter a hierarquia de navegação.
    var childCoordinators: [Coordinator] { get set }
    
    /// Controlador de navegação principal.
    var navigationController: UINavigationController { get set }
    
    /// Método inicial para iniciar o fluxo do coordenador.
    func start()
}
