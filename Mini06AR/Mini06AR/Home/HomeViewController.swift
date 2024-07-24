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

    




