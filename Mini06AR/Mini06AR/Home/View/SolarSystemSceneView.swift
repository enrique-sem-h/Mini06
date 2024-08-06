//
//  SolarSystemSceneView.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 27/07/24.
//

import UIKit
import SceneKit

/**
 A classe `SolarSystemSceneView` é responsável por configurar e exibir uma cena 3D do sistema solar usando SceneKit.
 */
class SolarSystemSceneView: SCNView {

    /**
     Inicializa uma nova `SolarSystemSceneView` com o quadro e os planetas fornecidos.
     
     - Parameters:
        - frame: O quadro da visualização.
        - planets: Uma lista de planetas a serem exibidos na cena.
     */
    let cameraNode = SCNNode()
    
    init(frame: CGRect, planets: [Planet]) {
        super.init(frame: frame, options: [:])
        self.autoenablesDefaultLighting = true
        setupScene(planets: planets)
    }
    
    /**
     Inicializa uma nova `SolarSystemSceneView` a partir de um codificador.
     
     - Parameter coder: O codificador a ser utilizado.
     */
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScene(planets: [])
    }
    
    /**
     Configura a cena 3D com os planetas fornecidos.
     
     - Parameter planets: Uma lista de planetas a serem exibidos na cena.
     */
    private func setupScene(planets: [Planet]) {
        print("Setting up scene with \(planets.count) planets.")
        
        let scene = SCNScene()
        self.scene = scene
        self.allowsCameraControl = true
        
        if let backgroundImage = UIImage(named: "galaxy_texture") {
            scene.background.contents = backgroundImage
        } else {
            print("Error: Background image not found.")
        }
        
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 50)
        scene.rootNode.addChildNode(cameraNode)
        
        /**
         Adiciona um planeta à cena.
         
         - Parameters:
            - name: O nome do planeta.
            - radius: O raio do planeta.
            - distance: A distância do planeta do centro da cena.
            - texture: O nome da imagem de textura do planeta.
         - Returns: O nó do planeta criado.
         */
        func addPlanet(name: String, radius: CGFloat, distance: Float, modelName: String) -> SCNNode {
            guard let url = Bundle.main.url(forResource: modelName, withExtension: ".usdz"), let referenceNode = SCNReferenceNode(url: url) else { return SCNNode()}
            
            referenceNode.load()
            referenceNode.name = name
            referenceNode.scale = SCNVector3(radius, radius, radius)
            referenceNode.position = SCNVector3(x: distance, y: 0, z: 0)
            
            if modelName == "sun" {
                let light = SCNLight()
                light.intensity = 5000
                referenceNode.light = light
            }
            
            return referenceNode
        }
        
        /**
         Adiciona um planeta em órbita à cena.
         
         - Parameters:
            - name: O nome do planeta.
            - radius: O raio do planeta.
            - distance: A distância do planeta do centro da cena.
            - texture: O nome da imagem de textura do planeta.
            - duration: A duração da órbita do planeta.
         */
        func addOrbitingPlanet(name: String, radius: CGFloat, distance: Float, modelName: String, duration: TimeInterval) {
            let orbitNode = SCNNode()
            let planetNode = addPlanet(name: name, radius: radius, distance: distance, modelName: modelName)
            orbitNode.name = "orbit"
            orbitNode.addChildNode(planetNode)
            scene.rootNode.addChildNode(orbitNode)
            
            let rotation = CABasicAnimation(keyPath: "rotation")
            rotation.toValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float.pi * 2))
            rotation.duration = duration
            rotation.repeatCount = .infinity
            orbitNode.addAnimation(rotation, forKey: "rotation")
        }
        
        let sunNode = addPlanet(name: "Sun", radius: 3.0, distance: 0, modelName: "sun")
        scene.rootNode.addChildNode(sunNode)
        
        addOrbitingPlanet(name: "Mercury", radius: 0.5, distance: 6, modelName: "mercury", duration: 10)
        addOrbitingPlanet(name: "Venus", radius: 0.95, distance: 10, modelName: "venus", duration: 20)
        addOrbitingPlanet(name: "Earth", radius: 1.0, distance: 14, modelName: "earth", duration: 30)
        
        let earthOrbitNode = scene.rootNode.childNodes.last!
        let moonNode = addPlanet(name: "Moon", radius: 0.27, distance: 2, modelName: "moon")
        let moonOrbitNode = SCNNode()
        moonOrbitNode.position = SCNVector3(x: 14, y: 0, z: 0)
        moonOrbitNode.addChildNode(moonNode)
        earthOrbitNode.addChildNode(moonOrbitNode)
        
        let moonRotation = CABasicAnimation(keyPath: "rotation")
        moonRotation.toValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float.pi * 2))
        moonRotation.duration = 5
        moonRotation.repeatCount = .infinity
        moonOrbitNode.addAnimation(moonRotation, forKey: nil)
        
        addOrbitingPlanet(name: "Mars", radius: 0.53, distance: 20, modelName: "mars", duration: 40)
        addOrbitingPlanet(name: "Jupiter", radius: 2.5, distance: 28, modelName: "jupiter", duration: 50)
        
        // Adição de Saturno e seus anéis
        let saturnOrbitNode = SCNNode()
        let saturnNode = addPlanet(name: "Saturn", radius: 2.0, distance: 36, modelName: "saturn")
        saturnOrbitNode.addChildNode(saturnNode)
        
        scene.rootNode.addChildNode(saturnOrbitNode)
        
        let saturnRotation = CABasicAnimation(keyPath: "rotation")
        saturnRotation.toValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float.pi * 2))
        saturnRotation.duration = 60
        saturnRotation.repeatCount = .infinity
        saturnOrbitNode.addAnimation(saturnRotation, forKey: nil)
        
        addOrbitingPlanet(name: "Uranus", radius: 1.5, distance: 44, modelName: "uranus", duration: 70)
        addOrbitingPlanet(name: "Neptune", radius: 1.5, distance: 52, modelName: "neptune", duration: 80)
        
        let sunRotation = CABasicAnimation(keyPath: "rotation")
        sunRotation.toValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float.pi * 2))
        sunRotation.duration = 30
        sunRotation.repeatCount = .infinity
        sunNode.addAnimation(sunRotation, forKey: nil)
    }
}
