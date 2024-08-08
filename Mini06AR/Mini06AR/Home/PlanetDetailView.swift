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

    private func createUIElements() {
        setupLabels()
        setupStackViews()
        setup3DView()
        setupBackgroundViews()
        setupConstraints()
    }

    private func setupLabels() {
        let celestialName = planet?.name ?? ""
        planetNameLabel = createPaddedLabel(text: planet?.name, baseFontSize: 46, font: "Signika-Bold", padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16), textColor: ColorCatalog.getTextColor(for: celestialName))
        

        
        nameAndMorseStackView = createStackView(arrangedSubviews: [planetNameLabel], axis: .horizontal, spacing: 15)
        planetDescriptionLabels = createDescriptionLabels()
    }

    private func setupStackViews() {
        stackView = createStackView(arrangedSubviews: [nameAndMorseStackView] + planetDescriptionLabels, axis: .vertical, spacing: 40)
    }

    private func setup3DView() {
        planet3DView = createPlanet3DView()
    }

    private func setupBackgroundViews() {
        let celestialName = planet?.name ?? ""
        planetBackgroundView = createBackgroundView(backgroundColor: ColorCatalog.black)
        textBackgroundView = createBackgroundView(
            backgroundColor: ColorCatalog.getTextBackgroundColor(for: celestialName)
        )
    }
    private func setupConstraints() {
        let navigationBarHeight: CGFloat = 90
        
        addSubview(textBackgroundView)
        addSubview(stackView)
        addSubview(planetBackgroundView)
        planetBackgroundView.addSubview(planet3DView)
        
        NSLayoutConstraint.activate([
            // Text Background Constraints
            textBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textBackgroundView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -8),
            textBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: navigationBarHeight + 16),
            textBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            // Stack View Constraints
            stackView.leadingAnchor.constraint(equalTo: textBackgroundView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: textBackgroundView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: textBackgroundView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: textBackgroundView.bottomAnchor, constant: -16),
            
            // Planet Background Constraints
            planetBackgroundView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 8),
            planetBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            planetBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: navigationBarHeight + 16),
            planetBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            // Planet 3D View Constraints
            planet3DView.centerXAnchor.constraint(equalTo: planetBackgroundView.centerXAnchor),
            planet3DView.centerYAnchor.constraint(equalTo: planetBackgroundView.centerYAnchor),
            planet3DView.widthAnchor.constraint(equalTo: planetBackgroundView.widthAnchor, multiplier: 0.9),
            planet3DView.heightAnchor.constraint(equalTo: planetBackgroundView.heightAnchor, multiplier: 0.8)
        ])
    }

    private func createPaddedLabel(text: String?, baseFontSize: CGFloat, font: String, padding: UIEdgeInsets = .zero, textColor: UIColor) -> PaddedLabel {
        let label = PaddedLabel()
        label.text = text
        label.textColor = textColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.padding = padding
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let adjustedFont = adjustFontSizeToFit(text: text, baseFontSize: baseFontSize, font: font, label: label)
        label.font = adjustedFont
        
        return label
    }

    private func adjustFontSizeToFit(text: String?, baseFontSize: CGFloat, font: String, label: PaddedLabel) -> UIFont {
        guard let text = text else { return UIFont(name: font, size: baseFontSize) ?? UIFont.systemFont(ofSize: baseFontSize) }
        
        var fontSize = baseFontSize
        let maxSize = CGSize(width: label.frame.width - label.padding.left - label.padding.right, height: CGFloat.greatestFiniteMagnitude)
        
        while fontSize > 0 {
            let font = UIFont(name: font, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
            let textAttributes = [NSAttributedString.Key.font: font]
            let textSize = (text as NSString).boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: textAttributes, context: nil).size
            
            if textSize.height <= label.frame.height - label.padding.top - label.padding.bottom && textSize.width <= label.frame.width - label.padding.left - label.padding.right {
                return font
            }
            
            fontSize -= 1
        }
        
        return UIFont(name: font, size: baseFontSize) ?? UIFont.systemFont(ofSize: baseFontSize)
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
            return createDescriptionLabel(text: descriptionText, celestialName: celestialName)
        }
    }

    private func createDescriptionLabel(text: String, celestialName: String) -> PaddedLabel {
        let label = createPaddedLabel(text: text, baseFontSize: 20, font: "Signika-Regular", padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 20), textColor: ColorCatalog.getDescriptionTextColor(for: celestialName))
        label.numberOfLines = 0
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.backgroundColor = ColorCatalog.white.withAlphaComponent(0.3)
        return label
    }

    private func createPlanet3DView() -> SCNView {
        let sceneView = SCNView()
        if let modelName = planet?.modelName {
            let planetScene = loadPlanetModel(named: modelName)
            sceneView.scene = planetScene
        }
        sceneView.autoenablesDefaultLighting = true
        setupCamera(for: sceneView)
        sceneView.allowsCameraControl = true
        sceneView.cameraControlConfiguration.allowsTranslation = false
        sceneView.backgroundColor = .clear
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        setupViewAppearance(for: sceneView)
        return sceneView
    }

    private func setupCamera(for sceneView: SCNView) {
        let cameraNode = SCNNode()
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        camera.orthographicScale = 1.0
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0, 0, 10)
        sceneView.scene?.rootNode.addChildNode(cameraNode)
    }

    private func setupViewAppearance(for view: SCNView) {
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 5
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

    private func loadPlanetModel(named name: String, rotating: Bool = true) -> SCNScene? {
        guard let scene = SCNScene(named: name) else { return nil }
        setupPlanetRotationIfNeeded(for: scene, rotating: rotating)
        return scene
    }

    private func setupPlanetRotationIfNeeded(for scene: SCNScene, rotating: Bool) {
        guard rotating else { return }
        let rotationAnimation = CABasicAnimation(keyPath: "rotation")
        rotationAnimation.toValue = NSValue(scnVector4: SCNVector4(0, 1, 0, Float.pi * 2))
        rotationAnimation.duration = 5
        rotationAnimation.repeatCount = .infinity
        scene.rootNode.addAnimation(rotationAnimation, forKey: "rotate")
    }
}
