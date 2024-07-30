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
        func addPlanet(name: String, radius: CGFloat, distance: Float, texture: String) -> SCNNode {
            let sphere = SCNSphere(radius: radius)
            if let planetTexture = UIImage(named: texture) {
                sphere.firstMaterial?.diffuse.contents = planetTexture
            } else {
                print("Error: Texture image for \(name) not found.")
            }
            let planetNode = SCNNode(geometry: sphere)
            planetNode.name = name
            planetNode.position = SCNVector3(x: distance, y: 0, z: 0)
            return planetNode
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
        
        let sunNode = addPlanet(name: "Sol", radius: 3.0, distance: 0, texture: "sun_texture")
        scene.rootNode.addChildNode(sunNode)
        
        addOrbitingPlanet(name: "Mercúrio", radius: 0.5, distance: 6, texture: "mercury_texture", duration: 10)
        addOrbitingPlanet(name: "Vênus", radius: 0.95, distance: 10, texture: "venus_texture", duration: 20)
        addOrbitingPlanet(name: "Terra", radius: 1.0, distance: 14, texture: "earth_texture", duration: 30)
        
        let earthOrbitNode = scene.rootNode.childNodes.last!
        let moonNode = addPlanet(name: "Lua", radius: 0.27, distance: 2, texture: "moon_texture")
        let moonOrbitNode = SCNNode()
        moonOrbitNode.position = SCNVector3(x: 14, y: 0, z: 0)
        moonOrbitNode.addChildNode(moonNode)
        earthOrbitNode.addChildNode(moonOrbitNode)
        
        let moonRotation = CABasicAnimation(keyPath: "rotation")
        moonRotation.toValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float.pi * 2))
        moonRotation.duration = 5
        moonRotation.repeatCount = .infinity
        moonOrbitNode.addAnimation(moonRotation, forKey: nil)
        
        addOrbitingPlanet(name: "Marte", radius: 0.53, distance: 20, texture: "mars_texture", duration: 40)
        addOrbitingPlanet(name: "Júpiter", radius: 2.5, distance: 28, texture: "jupiter_texture", duration: 50)
        
        // Adição de Saturno e seus anéis
        let saturnOrbitNode = SCNNode()
        let saturnNode = addPlanet(name: "Saturno", radius: 2.0, distance: 36, texture: "saturn_texture")
        saturnOrbitNode.addChildNode(saturnNode)
        
        let ringNode = SCNNode()
        let ring = SCNCylinder(radius: 5.0, height: 0.31)
        
        let ringMaterial = SCNMaterial()
        ringMaterial.diffuse.contents = UIImage(named: "saturn_ring_texture")
        ringMaterial.diffuse.wrapS = .repeat
        ringMaterial.diffuse.wrapT = .repeat
        
        let rotationMatrix = SCNMatrix4MakeRotation(Float.pi / 2, 0, 0, 1)
        ringMaterial.diffuse.contentsTransform = rotationMatrix
        
        ring.materials = [ringMaterial]
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
        
        let sunRotation = CABasicAnimation(keyPath: "rotation")
        sunRotation.toValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float.pi * 2))
        sunRotation.duration = 30
        sunRotation.repeatCount = .infinity
        sunNode.addAnimation(sunRotation, forKey: nil)
    }
}
