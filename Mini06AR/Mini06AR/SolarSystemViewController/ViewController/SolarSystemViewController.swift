//
//  SolarSystemViewController.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 19/07/24.
//

import UIKit

/**
 A classe `SolarSystemViewController` exibe a view do Sistema Solar.
 */
class SolarSystemViewController: UIViewController {
    var coordinator: MainCoordinator?
    
    init(coordinator: MainCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = SolarSystemARView(viewController: self)
    }
}
