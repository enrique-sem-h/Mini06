//
//  ViewController.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 19/07/24.
//

import UIKit

/**
 A classe `HomeViewController` é responsável por exibir a tela inicial com uma lista de planetas.
 */import UIKit

class HomeViewController: UIViewController {
    var coordinator: MainCoordinator?

    // Ajuste esses valores conforme necessário
    let baseDistance: CGFloat = 3 // Distância base para o Sol
    let distanceMultiplier: CGFloat = 5 // Multiplicador para ampliar as distâncias
    
    // Adicione velocidades de rotação variáveis (em segundos para uma volta completa)
    let planetSpeeds: [String: Double] = [
        "Mercúrio": 0.2, // Velocidade de rotação para Mercúrio (em segundos)
        "Vênus": 0.3,
        "Terra": 0.5,
        "Marte": 0.6,
        "Júpiter": 1.0,
        "Saturno": 1.2,
        "Urano": 1.5,
        "Netuno": 1.8
    ]

    let planets = [
        Planet(name: "Sol", description: "A estrela no centro do Sistema Solar, responsável por fornecer luz e calor à Terra.", imageName: "sun", radius: 696340.0, distanceFromSun: 10),
        Planet(name: "Mercúrio", description: "O menor planeta do Sistema Solar e o mais próximo do Sol.", imageName: "mercury", radius: 2439.7, distanceFromSun: 20),
        Planet(name: "Vênus", description: "O segundo planeta do Sistema Solar e o mais quente.", imageName: "venus", radius: 6051.8, distanceFromSun: 30),
        Planet(name: "Terra", description: "Nosso lar, o terceiro planeta do Sistema Solar.", imageName: "earth", radius: 6371.0, distanceFromSun: 40),
        Planet(name: "Marte", description: "O Planeta Vermelho, o quarto do Sistema Solar.", imageName: "mars", radius: 3389.5, distanceFromSun: 50),
        Planet(name: "Júpiter", description: "O maior planeta do Sistema Solar, o quinto a partir do Sol.", imageName: "jupiter", radius: 69911, distanceFromSun: 60),
        Planet(name: "Saturno", description: "Conhecido pelos seus anéis impressionantes, é o sexto planeta do Sistema Solar.", imageName: "saturn", radius: 58232, distanceFromSun: 70),
        Planet(name: "Urano", description: "O sétimo planeta do Sistema Solar, conhecido pela sua cor azulada.", imageName: "uranus", radius: 25362, distanceFromSun: 80),
        Planet(name: "Netuno", description: "O oitavo planeta do Sistema Solar, conhecido por seus ventos fortes.", imageName: "neptune", radius: 24622, distanceFromSun: 90)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        setupSolarSystem()
    }
    
    func setupSolarSystem() {
        let sunView = createPlanetView(name: "Sol", imageName: "sun", radius: 50)
        sunView.center = view.center
        view.addSubview(sunView)
        
        for planet in planets.filter({ $0.name != "Sol" }) {
            let planetView = createPlanetView(name: planet.name, imageName: planet.imageName, radius: 20)
            let distance = CGFloat(planet.distanceFromSun) * distanceMultiplier
            let orbitPath = UIBezierPath(arcCenter: view.center, radius: distance, startAngle: 0, endAngle: .pi * 2, clockwise: true)
            
            let orbitLayer = CAShapeLayer()
            orbitLayer.path = orbitPath.cgPath
            orbitLayer.strokeColor = UIColor.gray.cgColor
            orbitLayer.fillColor = UIColor.clear.cgColor
            view.layer.addSublayer(orbitLayer)
            
            planetView.center = CGPoint(x: view.center.x + distance, y: view.center.y)
            view.addSubview(planetView)
            
            let speed = planetSpeeds[planet.name] ?? 1.0 // Velocidade padrão se não especificada
            animatePlanet(planetView: planetView, orbitPath: orbitPath, duration: speed)
        }
    }
    
    func createPlanetView(name: String, imageName: String, radius: CGFloat) -> UIView {
        let planetView = UIView()
        planetView.backgroundColor = .clear
        
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: radius * 2, height: radius * 2)
        imageView.center = CGPoint(x: radius, y: radius)
        
        planetView.addSubview(imageView)
        planetView.frame.size = CGSize(width: radius * 2, height: radius * 2)
        return planetView
    }
    
    func animatePlanet(planetView: UIView, orbitPath: UIBezierPath, duration: Double) {
        let orbitAnimation = CAKeyframeAnimation(keyPath: "position")
        orbitAnimation.path = orbitPath.cgPath
        orbitAnimation.duration = duration * 100.0 // Ajuste o fator de multiplicação conforme necessário
        orbitAnimation.repeatCount = .infinity
        planetView.layer.add(orbitAnimation, forKey: "orbit")
    }
    
    @objc func showARView(_ sender: UIButton) {
        let planet = planets[sender.tag]
        coordinator?.showARView(for: planet)
    }
    
    @objc func showSolarSystemView(_ sender: UIButton) {
        let planet = planets[sender.tag]
        coordinator?.showSolarSystemView()
    }
}

    




