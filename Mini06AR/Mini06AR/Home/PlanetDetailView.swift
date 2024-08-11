//
//  PlanetDetailView.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 22/07/24.
//

import UIKit
import SceneKit

/**
 A classe `PlanetDetailView` é responsável por exibir uma visão detalhada de um planeta específico, incluindo informações textuais e um modelo 3D do planeta.
 
 Esta classe configura e organiza os elementos da interface do usuário, como rótulos e uma visualização 3D, em uma hierarquia de visualizações estruturada.
 */
class PlanetDetailView: UIView {
    /// O objeto `Planet` contendo as informações e o modelo 3D do planeta.
    var planet: Planet?

    /// Rótulo para exibir o nome do planeta.
    var planetNameLabel: PaddedLabel!
    
    /// Rótulos para exibir as descrições do planeta.
    var planetDescriptionLabels: [PaddedLabel] = []
    
    /// Visualização 3D para exibir o modelo do planeta.
    var planet3DView: SCNView!
    
    /// Stack view para organizar os rótulos de nome e descrições do planeta.
    var stackView: UIStackView!
    
    /// Fundo de visualização para os elementos textuais.
    var textBackgroundView: UIView!
    
    /// Fundo de visualização para o modelo 3D do planeta.
    var planetBackgroundView: UIView!
    
    /// Stack view para organizar o rótulo de nome e a visualização correspondente.
    var nameAndMorseStackView: UIStackView!
    
    /// Imagem do planeta.
    var planetImageView: UIImageView!

    /**
     Inicializa a `PlanetDetailView` com um planeta específico.
     
     - Parameter planet: O objeto `Planet` cujos detalhes serão exibidos.
     */
    init(planet: Planet) {
        super.init(frame: .zero)
        self.planet = planet
        self.backgroundColor = ColorCatalog.getBackgroundColor(for: planet.name)
        createUIElements()
    }

    /**
     Inicializador necessário ao utilizar storyboards ou XIBs.
     
     - Parameter coder: O objeto `NSCoder` usado para inicializar a visualização.
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /**
     Cria e configura todos os elementos da interface do usuário na `PlanetDetailView`.
     
     Este método organiza a hierarquia das visualizações, define suas propriedades e aplica restrições de layout.
     */
    private func createUIElements() {
        setupLabels()
        setupStackViews()
        setup3DView()
        setupBackgroundViews()
        setupConstraints()
    }

    /**
     Configura os rótulos que exibem o nome e as descrições do planeta.
     
     - Nota: Este método também cria uma stack view para o nome e o código Morse do planeta.
     */
    private func setupLabels() {
        let celestialName = planet?.name ?? ""
        planetNameLabel = createPaddedLabel(
            text: planet?.name,
            baseFontSize: 46,
            font: "Signika-Bold",
            padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16),
            textColor: ColorCatalog.getTextColor(for: celestialName)
        )
        
        nameAndMorseStackView = createStackView(arrangedSubviews: [planetNameLabel], axis: .horizontal, spacing: 15)
        planetDescriptionLabels = createDescriptionLabels()
    }

    /**
     Configura as stack views para organizar o layout dos elementos.
     
     Este método cria uma stack view vertical que contém os rótulos de nome e as descrições.
     */
    private func setupStackViews() {
        stackView = createStackView(arrangedSubviews: [nameAndMorseStackView] + planetDescriptionLabels, axis: .vertical, spacing: 40)
    }

    /**
     Configura a visualização 3D para exibir o modelo do planeta.
     
     Este método carrega o modelo 3D do planeta e ajusta as configurações de câmera e aparência.
     */
    private func setup3DView() {
        planet3DView = createPlanet3DView()
    }

    /**
     Configura as visualizações de fundo para os elementos textuais e o modelo 3D.
     
     Este método cria duas visualizações de fundo separadas para os textos e o modelo 3D, definindo suas cores e estilos.
     */
    private func setupBackgroundViews() {
        let celestialName = planet?.name ?? ""
        planetBackgroundView = createBackgroundView(backgroundColor: ColorCatalog.black)
        textBackgroundView = createBackgroundView(backgroundColor: ColorCatalog.getTextBackgroundColor(for: celestialName))
    }

    /**
     Define as restrições de layout para organizar os elementos dentro da `PlanetDetailView`.
     
     Este método aplica as restrições necessárias para posicionar corretamente as visualizações de texto, o modelo 3D e seus fundos.
     */
    private func setupConstraints() {
        let navigationBarHeight: CGFloat = 90
        
        addSubview(textBackgroundView)
        addSubview(stackView)
        addSubview(planetBackgroundView)
        planetBackgroundView.addSubview(planet3DView)
        
        NSLayoutConstraint.activate([
            // Restrições do fundo de texto
            textBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textBackgroundView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -8),
            textBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: navigationBarHeight + 16),
            textBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            // Restrições da stack view
            stackView.leadingAnchor.constraint(equalTo: textBackgroundView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: textBackgroundView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: textBackgroundView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: textBackgroundView.bottomAnchor, constant: -16),
            
            // Restrições do fundo do planeta
            planetBackgroundView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 8),
            planetBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            planetBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: navigationBarHeight + 16),
            planetBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            // Restrições da visualização 3D do planeta
            planet3DView.centerXAnchor.constraint(equalTo: planetBackgroundView.centerXAnchor),
            planet3DView.centerYAnchor.constraint(equalTo: planetBackgroundView.centerYAnchor),
            planet3DView.widthAnchor.constraint(equalTo: planetBackgroundView.widthAnchor, multiplier: 0.9),
            planet3DView.heightAnchor.constraint(equalTo: planetBackgroundView.heightAnchor, multiplier: 0.8)
        ])
    }

    /**
     Cria um rótulo personalizado com preenchimento e estilo ajustáveis.
     
     - Parameters:
       - text: O texto a ser exibido no rótulo.
       - baseFontSize: O tamanho base da fonte.
       - font: O nome da fonte.
       - padding: O preenchimento a ser aplicado ao rótulo.
       - textColor: A cor do texto do rótulo.
     - Returns: Um rótulo personalizado `PaddedLabel`.
     */
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

    /**
     Ajusta o tamanho da fonte para caber dentro do rótulo `PaddedLabel`.
     
     - Parameters:
       - text: O texto a ser exibido.
       - baseFontSize: O tamanho base da fonte.
       - font: O nome da fonte.
       - label: O rótulo para o qual a fonte será ajustada.
     - Returns: Uma fonte ajustada para caber no rótulo.
     */
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

    /**
     Cria uma stack view com subvisualizações, eixo e espaçamento definidos.
     
     - Parameters:
       - arrangedSubviews: As subvisualizações a serem organizadas na stack view.
       - axis: O eixo da stack view.
       - spacing: O espaçamento entre as subvisualizações.
     - Returns: Uma stack view configurada.
     */
    private func createStackView(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    /**
     Cria rótulos para as descrições do planeta com base nas informações disponíveis.
     
     - Returns: Um array de `PaddedLabel` contendo as descrições do planeta.
     */
    private func createDescriptionLabels() -> [PaddedLabel] {
        let celestialName = planet?.name ?? ""
        return ["Description 1", "Description 2", "Description 3"].compactMap { descriptionKey in
            guard let descriptionText = planet?.descriptions[descriptionKey] else { return nil }
            return createDescriptionLabel(text: descriptionText, celestialName: celestialName)
        }
    }

    /**
     Cria um rótulo de descrição personalizado para o planeta.
     
     - Parameters:
       - text: O texto da descrição.
       - celestialName: O nome do planeta.
     - Returns: Um rótulo `PaddedLabel` configurado para exibir a descrição.
     */
    private func createDescriptionLabel(text: String, celestialName: String) -> PaddedLabel {
        let label = createPaddedLabel(
            text: text,
            baseFontSize: 20,
            font: "Signika-Regular",
            padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 20),
            textColor: ColorCatalog.getDescriptionTextColor(for: celestialName)
        )
        label.numberOfLines = 0
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.backgroundColor = ColorCatalog.white.withAlphaComponent(0.3)
        return label
    }

    /**
     Cria uma visualização 3D configurada para exibir o modelo do planeta.
     
     - Returns: Uma `SCNView` configurada para exibir o modelo 3D do planeta.
     */
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

    /**
     Configura a câmera da visualização 3D para uma melhor exibição do planeta.
     
     - Parameter sceneView: A visualização 3D que conterá a câmera.
     */
    private func setupCamera(for sceneView: SCNView) {
        let cameraNode = SCNNode()
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        camera.orthographicScale = 1.0
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0, 0, 10)
        sceneView.scene?.rootNode.addChildNode(cameraNode)
    }

    /**
     Configura a aparência da visualização 3D, incluindo cantos arredondados e sombra.
     
     - Parameter view: A visualização 3D a ser configurada.
     */
    private func setupViewAppearance(for view: SCNView) {
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 5
    }

    /**
     Cria uma visualização de fundo com cor e opacidade personalizadas.
     
     - Parameters:
       - alpha: A opacidade da visualização de fundo.
       - backgroundColor: A cor de fundo da visualização.
     - Returns: Uma `UIView` configurada como fundo.
     */
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

    /**
     Carrega o modelo 3D do planeta a partir de um arquivo.
     
     - Parameters:
       - name: O nome do arquivo de modelo 3D.
       - rotating: Um booleano que indica se o modelo deve ter uma animação de rotação.
     - Returns: Um `SCNScene` contendo o modelo 3D do planeta.
     */
    private func loadPlanetModel(named name: String, rotating: Bool = true) -> SCNScene? {
        guard let scene = SCNScene(named: name) else { return nil }
        setupPlanetRotationIfNeeded(for: scene, rotating: rotating)
        return scene
    }

    /**
     Configura a rotação automática do planeta, se necessário.
     
     - Parameters:
       - scene: A cena que contém o modelo 3D do planeta.
       - rotating: Um booleano que indica se a rotação deve ser aplicada.
     */
    private func setupPlanetRotationIfNeeded(for scene: SCNScene, rotating: Bool) {
        guard rotating else { return }
        let rotationAnimation = CABasicAnimation(keyPath: "rotation")
        rotationAnimation.toValue = NSValue(scnVector4: SCNVector4(0, 1, 0, Float.pi * 2))
        rotationAnimation.duration = 5
        rotationAnimation.repeatCount = .infinity
        scene.rootNode.addAnimation(rotationAnimation, forKey: "rotate")
    }
}
