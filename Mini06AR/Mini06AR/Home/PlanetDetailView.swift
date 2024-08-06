//
//  PlanetDetailView.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 22/07/24.
//

import UIKit
import SceneKit

class PaddedLabel: UILabel {
    var padding: UIEdgeInsets = .zero
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: padding.top, left: padding.left, bottom: padding.bottom, right: padding.right)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let width = size.width + padding.left + padding.right
        let height = size.height + padding.top + padding.bottom
        return CGSize(width: width, height: height)
    }
}

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
        planetNameLabel = createPaddedLabel(text: planet?.name, fontSize: 46, fontWeight: .bold, padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16))
        
        let morseCodeLabel = createPaddedLabel(text: planet?.morseCode, fontSize: 30, padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16))
        
        nameAndMorseStackView = createStackView(arrangedSubviews: [planetNameLabel, morseCodeLabel], axis: .horizontal, spacing: 15)
        
        planetDescriptionLabels = createDescriptionLabels()
        
        planet3DView = createPlanet3DView()
        planetBackgroundView = createBackgroundView()
        
        stackView = createStackView(arrangedSubviews: [nameAndMorseStackView] + planetDescriptionLabels, axis: .vertical, spacing: 40)
        
        textBackgroundView = createBackgroundView(withAlpha: 0.5)
        
        setupViews()
    }
    
    private func createPaddedLabel(text: String?, fontSize: CGFloat, fontWeight: UIFont.Weight = .regular, padding: UIEdgeInsets = .zero) -> PaddedLabel {
        let label = PaddedLabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        label.textAlignment = .left
        label.textColor = .label
        label.numberOfLines = 0 
        label.lineBreakMode = .byWordWrapping // Ensure that the text wraps correctly
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
        return ["Description 1", "Description 2", "Description 3"].compactMap { descriptionKey in
            guard let descriptionText = planet?.descriptions[descriptionKey] else { return nil }
            let descriptionLabel = createPaddedLabel(text: descriptionText, fontSize: 24, padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 20))
            descriptionLabel.numberOfLines = 0
            descriptionLabel.layer.cornerRadius = 10
            descriptionLabel.layer.masksToBounds = true
            descriptionLabel.backgroundColor = UIColor.systemGray5.withAlphaComponent(0.3)
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
    
    private func createBackgroundView(withAlpha alpha: CGFloat = 1.0) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6.withAlphaComponent(alpha)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 5
        return view
    }
    
    private func setupViews() {
        let navigationBarHeight: CGFloat = 90
        
        backgroundColor = .systemBackground
        
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
            planet3DView.heightAnchor.constraint(equalTo: planetBackgroundView.widthAnchor, multiplier: 0.5),
            planet3DView.widthAnchor.constraint(equalTo: planet3DView.heightAnchor),
        ])
    }
}
