//
//  PlanetDetailView.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 22/07/24.
//

import UIKit
import SceneKit

class PlanetDetailView: UIView {
    var planet: Planet?
    
    var planetNameLabel: UILabel!
    var planetDescriptionLabel: UILabel!
    var planet3DView: SCNView!
    var stackView: UIStackView!
    var textBackgroundView: UIView!
    var planetBackgroundView: UIView!
    var nameAndMorseStackView: UIStackView!
    var planetImageView: UIImageView!
    
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
        if let planet = scene.rootNode.childNodes.first {
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
            label.font = UIFont.boldSystemFont(ofSize: 34)
            label.textAlignment = .left
            label.textColor = .label
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let morseCodeLabel = UILabel()
        morseCodeLabel.text = planet?.morseCode
        morseCodeLabel.font = UIFont.systemFont(ofSize: 28)
        morseCodeLabel.textAlignment = .left
        morseCodeLabel.textColor = .label
        morseCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameAndMorseStackView = {
            let stackView = UIStackView(arrangedSubviews: [planetNameLabel, morseCodeLabel])
            stackView.axis = .horizontal
            stackView.spacing = 30
            stackView.alignment = .trailing
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        planetDescriptionLabel = {
            let descriptionLabel = UILabel()
            descriptionLabel.text = planet?.descriptions["Descrição"]
            descriptionLabel.font = UIFont.systemFont(ofSize: 18)
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
            sceneView.translatesAutoresizingMaskIntoConstraints = false
            return sceneView
        }()
        
        
        planetBackgroundView = {
            let view = UIView()
            view.backgroundColor = UIColor.systemGray6
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        stackView = {
            let stackView = UIStackView(arrangedSubviews: [nameAndMorseStackView, planetDescriptionLabel])
            stackView.axis = .vertical
            stackView.spacing = 10
            stackView.alignment = .leading
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        textBackgroundView = {
            let view = UIView()
            view.backgroundColor = UIColor.systemGray5
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        setupViews()
    }
    
    private func setupViews() {
        let screenWidth = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).flatMap({ $0.windows }).first(where: { $0.isKeyWindow })?.bounds.width ?? 0
        let navigationBarHeight: CGFloat = 90
        
        backgroundColor = .systemBackground
        
        addSubview(textBackgroundView)
        addSubview(stackView)
        addSubview(planetBackgroundView)
        planetBackgroundView.addSubview(planet3DView)
        
        NSLayoutConstraint.activate([
            textBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -screenWidth / 2),
            textBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: navigationBarHeight),
            textBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: textBackgroundView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: navigationBarHeight + 16),
            
            planetBackgroundView.leadingAnchor.constraint(equalTo: textBackgroundView.trailingAnchor),
            planetBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            planetBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: navigationBarHeight),
            planetBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            planet3DView.centerXAnchor.constraint(equalTo: planetBackgroundView.centerXAnchor),
            planet3DView.centerYAnchor.constraint(equalTo: planetBackgroundView.centerYAnchor),
            planet3DView.heightAnchor.constraint(equalTo: planetBackgroundView.widthAnchor, multiplier: 0.5),
            planet3DView.widthAnchor.constraint(equalTo: planet3DView.heightAnchor),
            

        ])
    }
}
