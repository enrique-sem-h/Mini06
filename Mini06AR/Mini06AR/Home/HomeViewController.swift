//
//  ViewController.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 19/07/24.
//

import UIKit

/**
 A classe `HomeViewController` é responsável por exibir a tela inicial com uma lista de planetas.
 */

import UIKit
class HomeViewController: UIViewController {
    var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        for planet in planets {
            let button = UIButton(type: .system)
            button.setTitle(planet.name, for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.addTarget(self, action: #selector(showARView(_:)), for: .touchUpInside)
            button.tag = planets.firstIndex(where: { $0.name == planet.name }) ?? 0
            stackView.addArrangedSubview(button)
        }

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    @objc func showARView(_ sender: UIButton) {
        let planet = planets[sender.tag]
        coordinator?.showARView(for: planet)
    }
}
