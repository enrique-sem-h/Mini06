//
//  HomeView.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 27/07/24.
//

import UIKit
import SceneKit

class HomeView: UIView {
    var planetBoxView: UIView!
    var isPlanetBoxVisible = true
    var planets: [Planet] = []
    var showARView: ((Planet) -> Void)?
    
    init(frame: CGRect, planets: [Planet]) {
        self.planets = planets
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        // Configuração da cena
        let sceneView = SCNView(frame: self.frame)
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        self.addSubview(sceneView)
        
        // Adicionando background
        scene.background.contents = UIImage(named: "galaxy_texture")
        
        // Adicionando a câmera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 50)
        scene.rootNode.addChildNode(cameraNode)
        
        // Função para adicionar um planeta
        func addPlanet(name: String, radius: CGFloat, distance: Float, texture: String) -> SCNNode {
            let sphere = SCNSphere(radius: radius)
            sphere.firstMaterial?.diffuse.contents = UIImage(named: texture)
            let planetNode = SCNNode(geometry: sphere)
            planetNode.position = SCNVector3(x: distance, y: 0, z: 0)
            return planetNode
        }
        
        // Função para adicionar uma órbita animada
        func addOrbitingPlanet(name: String, radius: CGFloat, distance: Float, texture: String, duration: TimeInterval) {
            let orbitNode = SCNNode()
            let planetNode = addPlanet(name: name, radius: radius, distance: distance, texture: texture)
            orbitNode.addChildNode(planetNode)
            scene.rootNode.addChildNode(orbitNode)
            
            let rotation = CABasicAnimation(keyPath: "rotation")
            rotation.toValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float.pi * 2))
            rotation.duration = duration
            rotation.repeatCount = .infinity
            orbitNode.addAnimation(rotation, forKey: nil)
        }
        
        // Adicionando o Sol
        let sunNode = addPlanet(name: "Sol", radius: 3.0, distance: 0, texture: "sun_texture")
        scene.rootNode.addChildNode(sunNode)
        
        // Adicionando os planetas com órbitas
        addOrbitingPlanet(name: "Mercúrio", radius: 0.5, distance: 6, texture: "mercury_texture", duration: 10)
        addOrbitingPlanet(name: "Vênus", radius: 0.95, distance: 10, texture: "venus_texture", duration: 20)
        addOrbitingPlanet(name: "Terra", radius: 1.0, distance: 14, texture: "earth_texture", duration: 30)
        
        // Adicionando a Lua em órbita da Terra
        let earthOrbitNode = scene.rootNode.childNodes.last!
        let moonNode = addPlanet(name: "Lua", radius: 0.27, distance: 2, texture: "moon_texture")
        let moonOrbitNode = SCNNode()
        moonOrbitNode.position = SCNVector3(x: 14, y: 0, z: 0)
        moonOrbitNode.addChildNode(moonNode)
        earthOrbitNode.addChildNode(moonOrbitNode)
        
        // Animação da Lua
        let moonRotation = CABasicAnimation(keyPath: "rotation")
        moonRotation.toValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float.pi * 2))
        moonRotation.duration = 5
        moonRotation.repeatCount = .infinity
        moonOrbitNode.addAnimation(moonRotation, forKey: nil)
        
        addOrbitingPlanet(name: "Marte", radius: 0.53, distance: 20, texture: "mars_texture", duration: 40)
        addOrbitingPlanet(name: "Júpiter", radius: 2.5, distance: 28, texture: "jupiter_texture", duration: 50)
        
        // Adicionando Saturno com anel
        let saturnOrbitNode = SCNNode()
        let saturnNode = addPlanet(name: "Saturno", radius: 2.0, distance: 36, texture: "saturn_texture")
        saturnOrbitNode.addChildNode(saturnNode)

        // Adicionando o anel de Saturno como um cilindro
        let ringNode = SCNNode()
        let ring = SCNCylinder(radius: 5.0, height: 0.31) // Altura pequena para fazer um círculo

        // Configurar o material do anel
        let ringMaterial = SCNMaterial()
        ringMaterial.diffuse.contents = UIImage(named: "saturn_ring_texture")
        ringMaterial.diffuse.wrapS = .repeat
        ringMaterial.diffuse.wrapT = .repeat

        // Ajustar a orientação da textura
        // Ajustar a transformação para girar a textura
        let rotationMatrix = SCNMatrix4MakeRotation(Float.pi / 2, 0, 0, 1)
        ringMaterial.diffuse.contentsTransform = rotationMatrix

        ring.materials = [ringMaterial] // Definindo o material para o cilindro
        ringNode.geometry = ring
        ringNode.position = SCNVector3(0, 0, 0)
        saturnNode.addChildNode(ringNode)

        scene.rootNode.addChildNode(saturnOrbitNode)
        
        let saturnRotation = CABasicAnimation(keyPath: "rotation")
        saturnRotation.toValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float.pi * 2))
        saturnRotation.duration = 60
        saturnRotation.repeatCount = .infinity
        saturnOrbitNode.addAnimation(saturnRotation, forKey: nil)
        
        addOrbitingPlanet(name: "Urano", radius: 1.5, distance: 44, texture: "uranus_texture", duration: 70)
        addOrbitingPlanet(name: "Netuno", radius: 1.5, distance: 52, texture: "neptune_texture", duration: 80)
        
        // Animação do Sol
        let sunRotation = CABasicAnimation(keyPath: "rotation")
        sunRotation.toValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float.pi * 2))
        sunRotation.duration = 30
        sunRotation.repeatCount = .infinity
        sunNode.addAnimation(sunRotation, forKey: nil)
        
        setupGlassmorphismBox()
        setupToggleButton()
    }
    
    private func setupGlassmorphismBox() {
        // Glassmorphism box
        planetBoxView = UIView(frame: CGRect(x: 20, y: 80, width: 180, height: 460))
        planetBoxView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        planetBoxView.layer.cornerRadius = 15
        planetBoxView.layer.borderWidth = 1
        planetBoxView.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        planetBoxView.clipsToBounds = true
        
        // Add blur effect to box
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = planetBoxView.bounds
        blurEffectView.isUserInteractionEnabled = false
        blurEffectView.layer.cornerRadius = 15
        blurEffectView.clipsToBounds = true
        planetBoxView.addSubview(blurEffectView)
        
        self.addSubview(planetBoxView)
        
        // Add buttons inside the box
        setupPlanetSelectionButtons(in: planetBoxView)
    }
    
    private func setupPlanetSelectionButtons(in container: UIView) {
        let planetNames = planets.map { $0.name }
        let buttonWidth: CGFloat = container.frame.width - 20
        let buttonHeight: CGFloat = 40
        
        for (index, name) in planetNames.enumerated() {
            let button = UIButton(frame: CGRect(x: 10, y: 10 + index * Int(buttonHeight + 10), width: Int(buttonWidth), height: Int(buttonHeight)))
            button.setTitle(name, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.tag = index
            
            // Set glassmorphism style
            button.backgroundColor = UIColor.white.withAlphaComponent(0.3)
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
            button.clipsToBounds = true
            
            // Add blur effect to button
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = button.bounds
            blurEffectView.isUserInteractionEnabled = false
            blurEffectView.layer.cornerRadius = 10
            blurEffectView.clipsToBounds = true
            button.insertSubview(blurEffectView, at: 0)
            
            button.addTarget(self, action: #selector(planetButtonTapped(_:)), for: .touchUpInside)
            container.addSubview(button)
        }
    }
    
    private func setupToggleButton() {
        let toggleButton = UIButton(type: .system)
        toggleButton.setTitle("Toggle Planets", for: .normal)
        toggleButton.setTitleColor(.white, for: .normal)
        toggleButton.frame = CGRect(x: 20, y: 560, width: 180, height: 40)
        
        toggleButton.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        toggleButton.layer.cornerRadius = 10
        toggleButton.layer.borderWidth = 1
        toggleButton.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        toggleButton.clipsToBounds = true
        
        // Add blur effect to button
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = toggleButton.bounds
        blurEffectView.isUserInteractionEnabled = false
        blurEffectView.layer.cornerRadius = 10
        blurEffectView.clipsToBounds = true
        toggleButton.insertSubview(blurEffectView, at: 0)
        
        toggleButton.addTarget(self, action: #selector(togglePlanetBox), for: .touchUpInside)
        self.addSubview(toggleButton)
    }
    
    @objc private func togglePlanetBox() {
        isPlanetBoxVisible.toggle()
        planetBoxView.isHidden = !isPlanetBoxVisible
    }
    
    @objc private func planetButtonTapped(_ sender: UIButton) {
        let planetIndex = sender.tag
        let selectedPlanet = planets[planetIndex]
        showARView?(selectedPlanet)
    }
}
