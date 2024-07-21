//
//  Coordinator.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 21/07/24.
//

import UIKit

/**
 The `Coordinator` protocol defines the basic structure for a navigation coordinator.
 A `Coordinator` is responsible for managing the navigation within the app.
 */
protocol Coordinator: AnyObject {
    /// List of child coordinators to maintain the navigation hierarchy.
    var childCoordinators: [Coordinator] { get set }
    
    /// Main navigation controller.
    var navigationController: UINavigationController { get set }
    
    /// Initial method to start the coordinator's flow.
    func start()
}
