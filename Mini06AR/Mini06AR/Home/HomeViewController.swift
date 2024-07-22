//
//  ViewController.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 19/07/24.
//

import UIKit

/**
 The `HomeViewController` class is responsible for displaying the home screen with a list of planets.
 */
class HomeViewController: UIViewController {
    var coordinator: MainCoordinator?

    let planets = [
        Planet(name: "Sol",
               description: "A estrela no centro do Sistema Solar, responsável por fornecer luz e calor à Terra.",
               imageName: "sun",
               radius: 696340.0,
               distanceFromSun: 0.0), // distância do Sol a si mesmo é 0
        Planet(name: "Mercúrio",
               description: "O menor planeta do Sistema Solar e o mais próximo do Sol.",
               imageName: "mercury",
               radius: 2439.7,
               distanceFromSun: 57.9),
        Planet(name: "Vênus",
               description: "O segundo planeta do Sistema Solar e o mais quente.",
               imageName: "venus",
               radius: 6051.8,
               distanceFromSun: 108.2),
        Planet(name: "Terra",
               description: "Nosso lar, o terceiro planeta do Sistema Solar.",
               imageName: "earth",
               radius: 6371.0,
               distanceFromSun: 149.6),
        Planet(name: "Marte",
               description: "O Planeta Vermelho, o quarto do Sistema Solar.",
               imageName: "mars",
               radius: 3389.5,
               distanceFromSun: 227.9),
        Planet(name: "Júpiter",
               description: "O maior planeta do Sistema Solar, o quinto a partir do Sol.",
               imageName: "jupiter",
               radius: 69911,
               distanceFromSun: 778.5),
        Planet(name: "Saturno",
               description: "Conhecido pelos seus anéis impressionantes, é o sexto planeta do Sistema Solar.",
               imageName: "saturn",
               radius: 58232,
               distanceFromSun: 1433.5),
        Planet(name: "Urano",
               description: "O sétimo planeta do Sistema Solar, conhecido pela sua cor azulada.",
               imageName: "uranus",
               radius: 25362,
               distanceFromSun: 2872.5),
        Planet(name: "Netuno",
               description: "O oitavo planeta do Sistema Solar, conhecido por seus ventos fortes.",
               imageName: "neptune",
               radius: 24622,
               distanceFromSun: 4495.1)
    ]

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
