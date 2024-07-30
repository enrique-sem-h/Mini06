//
//  HomeSceneView.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 26/07/24.
//

import UIKit
import SceneKit

class HomeSceneView: SCNScene {
    
    var planets: [Planet]
    
    init(planets: [Planet]) {
        self.planets = planets
        super.init()
        
        let camera = SCNNode()
        camera.position = SCNVector3(0, 0, 50)
        camera.camera = SCNCamera()
        camera.name = "camera"
        
        rootNode.camera = camera.camera
        
        createPlanets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createPlanets() {
        for planet in planets {
            let scn = SCNScene(named: planet.modelName)
            
            if let node = scn?.rootNode {
                var planetNode = SCNNode()
                planetNode = node
                planetNode.name = planet.modelName

                if rootNode.childNodes.isEmpty {
                    planetNode.position = rootNode.position
                } else {
                    planetNode.position = SCNVector3(x: (rootNode.childNodes.last?.position.x)! + 5, y: 0, z: 0)
                }
                
                self.rootNode.addChildNode(planetNode)
            }
        }
    }
    
    
    
}
