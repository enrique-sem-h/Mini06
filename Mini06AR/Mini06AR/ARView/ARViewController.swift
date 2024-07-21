//
//  ARViewController.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 19/07/24.
//

import UIKit

class ARViewController: UIViewController {
    var coordinator: ARCoordinator?
    var planet: Planet?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black

        let detailsButton = UIButton(type: .system)
        detailsButton.setTitle("Ver Detalhes", for: .normal)
        detailsButton.addTarget(self, action: #selector(showPlanetDetail), for: .touchUpInside)

        let solarSystemButton = UIButton(type: .system)
        solarSystemButton.setTitle("Ver Sistema Solar", for: .normal)
        solarSystemButton.addTarget(self, action: #selector(showSolarSystemView), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [detailsButton, solarSystemButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    @objc func showPlanetDetail() {
        coordinator?.showPlanetDetail()
    }

    @objc func showSolarSystemView() {
        coordinator?.showSolarSystemView()
    }
}


