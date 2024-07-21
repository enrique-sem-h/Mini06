//
//  ViewController.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 19/07/24.
//

import UIKit

class HomeViewController: UIViewController {
    var coordinator: MainCoordinator?

    let planets = [
        Planet(name: "Terra", description: "Nosso lar azul, o terceiro planeta do Sistema Solar.", imageName: "earth", radius: 6371.0, distanceFromSun: 149.6),
        Planet(name: "Marte", description: "O Planeta Vermelho, o quarto do Sistema Solar.", imageName: "mars", radius: 3389.5, distanceFromSun: 227.9)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        for planet in planets {
            let button = UIButton(type: .system)
            button.setTitle(planet.name, for: .normal)
            button.addTarget(self, action: #selector(showARView(_:)), for: .touchUpInside)
            button.tag = planets.firstIndex(where: { $0.name == planet.name }) ?? 0
            stackView.addArrangedSubview(button)
        }

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func showARView(_ sender: UIButton) {
        let planet = planets[sender.tag]
        coordinator?.showARView(for: planet)
    }
}
