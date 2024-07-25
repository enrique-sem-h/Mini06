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
class HomeViewController: UIViewController {
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        setupViews()
    }
    
    @objc private func planetTapped(_ sender: UIButton) {
        let planet = planets[sender.tag]
        coordinator?.showARView(for: planet)
        print("teste")
    }
    
    private func createPlanetButton(name: String, imageName: String, radius: CGFloat) -> UIButton {
        let planetButton = UIButton()
        planetButton.backgroundColor = .clear
        
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: radius * 2, height: radius * 2)
        imageView.center = CGPoint(x: radius, y: radius)
        
        planetButton.addSubview(imageView)
        planetButton.frame.size = CGSize(width: radius * 2, height: radius * 2)
        return planetButton
    }
    
    private func animatePlanet(planetView: UIView, orbitPath: UIBezierPath, duration: Double, nameLabel: UILabel) {
        let orbitAnimation = CAKeyframeAnimation(keyPath: "position")
        orbitAnimation.path = orbitPath.cgPath
        orbitAnimation.duration = duration * 100.0 // Ajuste o fator de multiplicação conforme necessário
        orbitAnimation.repeatCount = .infinity
        orbitAnimation.calculationMode = .paced
        
        let labelAnimation = CAKeyframeAnimation(keyPath: "position")
        labelAnimation.path = orbitPath.cgPath
        labelAnimation.duration = duration * 100.0 // Ajuste o fator de multiplicação conforme necessário
        labelAnimation.repeatCount = .infinity
        labelAnimation.calculationMode = .paced
        
        planetView.layer.add(orbitAnimation, forKey: "orbit")
        nameLabel.layer.add(labelAnimation, forKey: "orbitLabel")
    }
    
    private func setupSolarSystem() {
            let maxDistance = planets.map { $0.distanceFromSun }.max() ?? 1
            let screenSize = min(view.bounds.width, view.bounds.height)
            let maxAllowedDistance = screenSize / 1.6 // Deixa espaço para o Sol e as margens
            
            let distanceMultiplier: CGFloat
            if maxDistance > maxAllowedDistance {
                distanceMultiplier = maxAllowedDistance / CGFloat(maxDistance)
            } else {
                distanceMultiplier = 5
            }
            
            let sunView = createPlanetButton(name: "Sol", imageName: "sun", radius: 50)
            sunView.center = view.center
            view.addSubview(sunView)
            
            for (index, planet) in planets.filter({ $0.name != "Sol" }).enumerated() {
                let planetButton = createPlanetButton(name: planet.name, imageName: planet.imageName, radius: 20)
                planetButton.tag = index
                let distance = CGFloat(planet.distanceFromSun) * distanceMultiplier
                let orbitPath = UIBezierPath(arcCenter: view.center, radius: distance, startAngle: 0, endAngle: .pi * 2, clockwise: true)
                
                let orbitLayer = CAShapeLayer()
                orbitLayer.path = orbitPath.cgPath
                orbitLayer.strokeColor = UIColor.gray.cgColor
                orbitLayer.fillColor = UIColor.clear.cgColor
                view.layer.addSublayer(orbitLayer)
                
                planetButton.center = CGPoint(x: view.center.x + distance, y: view.center.y)
                view.addSubview(planetButton)
                
                planetButton.addTarget(self, action: #selector(planetTapped(_:)), for: .allTouchEvents)
                
                let nameLabel = UILabel()
                nameLabel.text = planet.name
                nameLabel.textAlignment = .center
                nameLabel.font = UIFont.systemFont(ofSize: 12)
                nameLabel.sizeToFit()
                nameLabel.tag = 100 + index // Tag para identificar a label associada ao planeta
                view.addSubview(nameLabel)
                
                let speed = planetSpeeds[planet.name] ?? 1.0 // Velocidade padrão se não especificada
                animatePlanet(planetView: planetButton, orbitPath: orbitPath, duration: speed, nameLabel: nameLabel)
            }
        }
    
    private func setupViews() {
        setupSolarSystem()
    }
    
    @objc func showARView(_ sender: UIButton) {
        let planet = planets[sender.tag]
        coordinator?.showARView(for: planet)
    }
    
    @objc func showSolarSystemView(_ sender: UIButton) {
        coordinator?.showSolarSystemView()
    }
}






