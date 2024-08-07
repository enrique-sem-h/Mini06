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

    var planetNameLabel: PaddedLabel!
    var planetDescriptionLabels: [PaddedLabel] = []
    var planet3DView: SCNView!
    var stackView: UIStackView!
    var textBackgroundView: UIView!
    var planetBackgroundView: UIView!
    var nameAndMorseStackView: UIStackView!
    var planetImageView: UIImageView!

    init(planet: Planet) {
        super.init(frame: .zero)
        self.planet = planet
        
        self.backgroundColor = ColorCatalog.getBackgroundColor(for: planet.name)
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
        let celestialName = planet?.name ?? ""
        
        planetNameLabel = createPaddedLabel(text: planet?.name, fontSize: 46, fontWeight: .bold, padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16), textColor: ColorCatalog.getTextColor(for: celestialName))
        
        let morseCodeLabel = createPaddedLabel(text: planet?.morseCode, fontSize: 30, padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16), textColor: ColorCatalog.getTextColor(for: celestialName))
        
        nameAndMorseStackView = createStackView(arrangedSubviews: [planetNameLabel, morseCodeLabel], axis: .horizontal, spacing: 15)
        
        planetDescriptionLabels = createDescriptionLabels()
        
        planet3DView = createPlanet3DView()
        planetBackgroundView = createBackgroundView(backgroundColor: ColorCatalog.black)
        
        stackView = createStackView(arrangedSubviews: [nameAndMorseStackView] + planetDescriptionLabels, axis: .vertical, spacing: 40)
        
        textBackgroundView = createBackgroundView(withAlpha: 0.5, backgroundColor: ColorCatalog.yellow)
        
        setupViews()
    }

    private func createPaddedLabel(text: String?, fontSize: CGFloat, fontWeight: UIFont.Weight = .regular, padding: UIEdgeInsets = .zero, textColor: UIColor) -> PaddedLabel {
        let label = PaddedLabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        label.textAlignment = .left
        label.textColor = textColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.padding = padding
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func createStackView(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    private func createDescriptionLabels() -> [PaddedLabel] {
        let celestialName = planet?.name ?? ""
        return ["Description 1", "Description 2", "Description 3"].compactMap { descriptionKey in
            guard let descriptionText = planet?.descriptions[descriptionKey] else { return nil }
            let descriptionLabel = createPaddedLabel(text: descriptionText, fontSize: 24, padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 20), textColor: ColorCatalog.getDescriptionTextColor(for: celestialName))
            descriptionLabel.numberOfLines = 0
            descriptionLabel.layer.cornerRadius = 10
            descriptionLabel.layer.masksToBounds = true
            descriptionLabel.backgroundColor = ColorCatalog.white.withAlphaComponent(0.3)
            return descriptionLabel
        }
    }

    private func createPlanet3DView() -> SCNView {
        let sceneView = SCNView()
        if let modelName = planet?.modelName {
            let planetScene = loadPlanetModel(name: modelName)
            sceneView.scene = planetScene
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
        sceneView.layer.cornerRadius = 15
        sceneView.layer.masksToBounds = true
        sceneView.layer.shadowColor = UIColor.black.cgColor
        sceneView.layer.shadowOpacity = 0.25
        sceneView.layer.shadowOffset = CGSize(width: 0, height: 2)
        sceneView.layer.shadowRadius = 5
        return sceneView
    }

    private func createBackgroundView(withAlpha alpha: CGFloat = 1.0, backgroundColor: UIColor = ColorCatalog.blue) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor.withAlphaComponent(alpha)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 5
        return view
    }

    private func setupViews() {
        let navigationBarHeight: CGFloat = 90
        
        addSubview(textBackgroundView)
        addSubview(stackView)
        addSubview(planetBackgroundView)
        planetBackgroundView.addSubview(planet3DView)
        
        NSLayoutConstraint.activate([
            textBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textBackgroundView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -8),
            textBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: navigationBarHeight + 16),
            textBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            stackView.leadingAnchor.constraint(equalTo: textBackgroundView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: textBackgroundView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: textBackgroundView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: textBackgroundView.bottomAnchor, constant: -16),
            
            planetBackgroundView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 8),
            planetBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            planetBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: navigationBarHeight + 16),
            planetBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            planet3DView.centerXAnchor.constraint(equalTo: planetBackgroundView.centerXAnchor),
            planet3DView.centerYAnchor.constraint(equalTo: planetBackgroundView.centerYAnchor),
            planet3DView.widthAnchor.constraint(equalTo: planetBackgroundView.widthAnchor, multiplier: 0.9),
            planet3DView.heightAnchor.constraint(equalTo: planetBackgroundView.heightAnchor, multiplier: 0.8)
        ])
    }
}
