//
//  PlanetDetailView.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 22/07/24.
//

import Foundation
import UIKit
import SceneKit

class PlanetDetailView: UIView {
    var planet: Planet?
    
    var planetNameLabel: UILabel!
    var planetDescriptionLabel: UILabel!
    var planetRadiusLabel: UILabel!
    var planetDistanceLabel: UILabel!
    var planet3DView: SCNView!
    var stackView: UIStackView!
    
    init(planet: Planet) {
        super.init(frame: .zero)
        self.planet = planet
        
        self.backgroundColor = .systemBackground
        createUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadPlanetModel(name: String, rotating: Bool = true) -> SCNScene? {
        guard let scene = SCNScene(named: name) else {
            return nil
        }
        if let planet =  scene.rootNode.childNodes.first {
            planet.position = SCNVector3(0, 0, 0)
            scene.rootNode.addChildNode(planet)
        }
        if rotating {
            let rotationAnimation = CABasicAnimation(keyPath: "rotation")
            rotationAnimation.toValue = NSValue(scnVector4: SCNVector4(0, 1, 0, Float.pi * 2))
            rotationAnimation.duration = 5
            rotationAnimation.repeatCount = .infinity
            scene.rootNode.addAnimation(rotationAnimation, forKey: "rotate")
        }
        return scene
    }
    
    private func createUIElements() {
        planetNameLabel = {
            let label = UILabel()
            label.text = planet?.name
            label.font = UIFont.boldSystemFont(ofSize: 24)
            label.textAlignment = .center
            label.textColor = .label
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        planetDescriptionLabel = {
            let descriptionLabel = UILabel()
            descriptionLabel.text = planet?.descriptions["Descrição"]
            descriptionLabel.font = UIFont.systemFont(ofSize: 16)
            descriptionLabel.textAlignment = .left
            descriptionLabel.numberOfLines = 0
            descriptionLabel.textColor = .secondaryLabel
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            return descriptionLabel
        }()
        
        planet3DView = {
            let sceneView = SCNView()
            if let modelName = planet?.modelName {
                let planet = loadPlanetModel(name: modelName)
                sceneView.scene = planet
            }
            sceneView.autoenablesDefaultLighting = true
            let cameraNode = SCNNode()
            let camera = SCNCamera()
            camera.usesOrthographicProjection = true
            camera.orthographicScale = 1.0
            cameraNode.camera = camera
            cameraNode.position = SCNVector3(0, 0, 10)
            sceneView.scene?.rootNode.addChildNode(cameraNode)
            sceneView.allowsCameraControl = true
            sceneView.cameraControlConfiguration.allowsTranslation = false
            sceneView.backgroundColor = .clear
            return sceneView
        }()
        
        planetRadiusLabel = {
            let radiusLabel = UILabel()
            radiusLabel.text = NSLocalizedString("Radius:", comment: "") + "\(planet?.radius ?? 0)" + NSLocalizedString("km", comment: "")
            radiusLabel.font = UIFont.systemFont(ofSize: 16)
            radiusLabel.textAlignment = .center
            radiusLabel.textColor = .label
            radiusLabel.translatesAutoresizingMaskIntoConstraints = false
            return radiusLabel
        }()
        
        planetDistanceLabel = {
            let distanceLabel = UILabel()
            if planet?.name == "Sol" {
                distanceLabel.text = ""
            } else {
                distanceLabel.text = NSLocalizedString("Distance from sun:", comment: "") + "\(planet?.distanceFromSun ?? 0)" + NSLocalizedString("millions of km", comment: "")
            }
            distanceLabel.font = UIFont.systemFont(ofSize: 16)
            distanceLabel.textAlignment = .center
            distanceLabel.textColor = .label
            distanceLabel.translatesAutoresizingMaskIntoConstraints = false
            return distanceLabel
        }()
        
        stackView = {
            let stackView = UIStackView(arrangedSubviews: [planetNameLabel, planetDescriptionLabel, planet3DView, planetRadiusLabel, planetDistanceLabel])
            stackView.axis = .vertical
            stackView.spacing = 10
            stackView.alignment = .leading
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        setupViews()
    }
    
    private func setupViews() {
        let screenWidth = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).flatMap({ $0.windows }).first(where: { $0.isKeyWindow })?.bounds.width
        let defaultPadding = 120/0.16
        backgroundColor = .systemBackground
        addSubview(planet3DView)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            planet3DView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0.16 * (screenWidth ?? defaultPadding)),
            planet3DView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            planet3DView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            planet3DView.widthAnchor.constraint(equalTo: planet3DView.heightAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.2),
            stackView.leadingAnchor.constraint(equalTo: planet3DView.trailingAnchor, constant: 120),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -0.08 * (screenWidth ?? defaultPadding/2)),
        ])
    }
}
