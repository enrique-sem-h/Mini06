//
//  HomeView.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 27/07/24.
//

import UIKit

/**
 `HomeView` é uma subclasse de `UIView` que representa a tela principal do aplicativo `Mini06AR`.

 Esta visualização inclui elementos como botões para alternar entre diferentes modos de exibição, pausar a cena, acessar configurações e abrir uma visualização de Realidade Aumentada (AR). Além disso, exibe um `SolarSystemSceneView` com uma cena do sistema solar.
 */
class HomeView: UIView {
    
    /// Indica se o `planetBoxView` está visível.
    var isPlanetBoxVisible = false
    
    /// Array contendo objetos `Planet` para exibição.
    var planets: [Planet] = []
    
    /// Closure chamada para exibir a visualização de AR com o planeta selecionado.
    var showARView: ((Planet) -> Void)?
    
    /// Instância de `SolarSystemSceneView` que exibe o sistema solar.
    var sceneView: SolarSystemSceneView
    
    /// Closure chamada para exibir o controlador de visualização de AR.
    var showARViewController: (() -> Void)?
    
    /// Subview que exibe informações detalhadas sobre os planetas.
    private var planetBoxView: PlanetBoxView!
    
    /// Botão que alterna a visibilidade do `planetBoxView`.
    private var toggleButton: UIButton!
    
    /// Botão que abre as configurações.
    private var settingsButton: UIButton!
    
    /// Botão que pausa a cena do sistema solar.
    private var pauseButton: UIButton!
    
    /// Botão que inicia a visualização de AR.
    private var arButton: UIButton!
    
    /// Botão que exibe informações adicionais.
    var informationButton: UIButton!
    
    /// Indica se os botões de configurações estão visíveis.
    private var areSettingsButtonsVisible = false
    
    /// Constraint usada para esconder o `planetBoxView`.
    private var planetBoxViewLeadingHiddenConstraint: NSLayoutConstraint!
    
    /// Constraint usada para mostrar o `planetBoxView`.
    private var planetBoxViewLeadingVisibleConstraint: NSLayoutConstraint!
    
    /**
     Inicializa uma nova instância de `HomeView`.
     
     - Parameters:
        - frame: O retângulo que especifica o tamanho e a posição inicial da visualização.
        - planets: Array de objetos `Planet` a serem exibidos.
     */
    init(frame: CGRect, planets: [Planet]) {
        self.planets = planets
        sceneView = SolarSystemSceneView(frame: frame, planets: planets)
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Configura a visualização e seus subcomponentes, incluindo o `sceneView`, `planetBoxView` e botões de interação.
     */
    private func setupView() {
        sceneView = SolarSystemSceneView(frame: self.frame, planets: planets)
        self.addSubview(sceneView)
        
        planetBoxView = PlanetBoxView(frame: .zero, planets: planets)
        planetBoxView.isHidden = true
        planetBoxView.showARView = { [weak self] planet in
            self?.showARView?(planet)
        }
        planetBoxView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(planetBoxView)
        
        setupToggleButton()
        setupSettingsButton()
        setupPauseButton()
        setupARButton()
        setupInformationButton()
        
        planetBoxViewLeadingHiddenConstraint = planetBoxView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -250)
        planetBoxViewLeadingVisibleConstraint = planetBoxView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        
        NSLayoutConstraint.activate([
            planetBoxViewLeadingHiddenConstraint,
            planetBoxView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            planetBoxView.widthAnchor.constraint(equalToConstant: 200),
            planetBoxView.heightAnchor.constraint(equalToConstant: 570)
        ])
    }
    
    /**
     Configura o `toggleButton`, que alterna a visibilidade do `planetBoxView`.
     */
    private func setupToggleButton() {
        toggleButton = UIButton(type: .system)
        toggleButton.setTitle("Explore", for: .normal)
        toggleButton.tintColor = ColorCatalog.white
        toggleButton.titleLabel?.font = FontManager.semiboldFont(size: 16)
        toggleButton.backgroundColor = ColorCatalog.yellow
        toggleButton.layer.cornerRadius = 20
        toggleButton.clipsToBounds = true
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(toggleButton)
        
        NSLayoutConstraint.activate([
            toggleButton.widthAnchor.constraint(equalToConstant: 100),
            toggleButton.heightAnchor.constraint(equalToConstant: 40),
            toggleButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            toggleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        toggleButton.addTarget(self, action: #selector(togglePlanetBox), for: .touchUpInside)
    }
    
    /**
     Configura o `settingsButton`, que alterna a visibilidade dos botões de configuração.
     */
    private func setupSettingsButton() {
        settingsButton = UIButton(type: .system)
        let settingsImage = UIImage(systemName: "gearshape.fill")
        settingsButton.setImage(settingsImage, for: .normal)
        settingsButton.tintColor = ColorCatalog.white
        settingsButton.backgroundColor = ColorCatalog.blue
        settingsButton.layer.cornerRadius = 20
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            settingsButton.widthAnchor.constraint(equalToConstant: 40),
            settingsButton.heightAnchor.constraint(equalToConstant: 40),
            settingsButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            settingsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        settingsButton.addTarget(self, action: #selector(toggleSettingsButtons), for: .touchUpInside)
    }
    
    /**
     Configura o `informationButton`, que exibe informações adicionais.
     
     Este botão está inicialmente oculto e é exibido junto com outros botões de configuração.
     */
    private func setupInformationButton() {
        informationButton = UIButton(type: .system)
        let infoImage = UIImage(systemName: "info.circle")
        informationButton.setImage(infoImage, for: .normal)
        informationButton.tintColor = .white
        
        informationButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(informationButton)
        
        NSLayoutConstraint.activate([
            informationButton.widthAnchor.constraint(equalToConstant: 40),
            informationButton.heightAnchor.constraint(equalToConstant: 40),
            informationButton.topAnchor.constraint(equalTo: pauseButton.topAnchor, constant: 40),
            informationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        informationButton.isHidden = true
    }
    
    /**
     Configura o `pauseButton`, que pausa ou retoma a cena do sistema solar.
     
     Este botão também está inicialmente oculto e é exibido junto com outros botões de configuração.
     */
    private func setupPauseButton() {
        pauseButton = UIButton(type: .system)
        let pauseImage = UIImage(systemName: "pause.fill")
        pauseButton.setImage(pauseImage, for: .normal)
        pauseButton.tintColor = .white
        
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pauseButton)
        
        NSLayoutConstraint.activate([
            pauseButton.widthAnchor.constraint(equalToConstant: 40),
            pauseButton.heightAnchor.constraint(equalToConstant: 40),
            pauseButton.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 10),
            pauseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        pauseButton.isHidden = true
        pauseButton.addTarget(self, action: #selector(pause), for: .touchUpInside)
    }
    
    /**
     Configura o `arButton`, que inicia a visualização de AR.
     */
    private func setupARButton() {
        arButton = UIButton(type: .system)
        let arImage = UIImage(systemName: "arkit")
        arButton.setImage(arImage, for: .normal)
        arButton.tintColor = .white
        
        arButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(arButton)
        
        NSLayoutConstraint.activate([
            arButton.widthAnchor.constraint(equalToConstant: 40),
            arButton.heightAnchor.constraint(equalToConstant: 40),
            arButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            arButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        arButton.backgroundColor = ColorCatalog.blue
        arButton.layer.cornerRadius = 20
        arButton.layer.borderWidth = 1
        arButton.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        arButton.clipsToBounds = true
        
        arButton.addTarget(self, action: #selector(openARView), for: .touchUpInside)
    }
    
    /**
     Método chamado quando o `arButton` é pressionado.
     
     Exibe a visualização de AR e aplica uma animação de fade ao botão.
     */
    @objc private func openARView() {
        showARViewController?()
        
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 1.0
        fadeAnimation.toValue = 0.5
        fadeAnimation.duration = 0.2
        fadeAnimation.autoreverses = true
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        arButton.layer.add(fadeAnimation, forKey: "fadeAnimation")
    }
    
    /**
     Método chamado quando o `pauseButton` é pressionado.
     
     Alterna o estado de pausa da cena do sistema solar e aplica uma animação de pulsação ao botão.
     */
    @objc private func pause() {
        sceneView.scene?.isPaused.toggle()
        let newImage = sceneView.scene?.isPaused == true ? UIImage(systemName: "play.fill") : UIImage(systemName: "pause.fill")
        pauseButton.setImage(newImage, for: .normal)
        
        let pulseAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        pulseAnimation.values = [1.0, 1.2, 1.0]
        pulseAnimation.keyTimes = [0, 0.5, 1]
        pulseAnimation.duration = 0.4
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pauseButton.layer.add(pulseAnimation, forKey: "pulseAnimation")
    }
    
    /**
     Método chamado quando o `settingsButton` é pressionado.
     
     Alterna a visibilidade dos botões de configurações e aplica uma animação de rotação ao `settingsButton`.
     */
    @objc private func toggleSettingsButtons() {
        areSettingsButtonsVisible.toggle()
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = 0.3
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        settingsButton.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        UIView.animate(withDuration: 0.2) {
            let alpha: CGFloat = self.areSettingsButtonsVisible ? 1.0 : 0.0
            let transform: CGAffineTransform = self.areSettingsButtonsVisible ? .identity : CGAffineTransform(scaleX: 0.5, y: 0.5)
            
            self.pauseButton.alpha = alpha
            self.pauseButton.transform = transform
            self.pauseButton.isHidden = !self.areSettingsButtonsVisible
            
            self.informationButton.alpha = alpha
            self.informationButton.transform = transform
            self.informationButton.isHidden = !self.areSettingsButtonsVisible
        }
    }
    
    /**
     Método chamado quando o `toggleButton` é pressionado.
     
     Alterna a visibilidade do `planetBoxView`, aplicando uma animação de escala ao `toggleButton`.
     */
    @objc private func togglePlanetBox() {
        isPlanetBoxVisible.toggle()
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 1.1
        scaleAnimation.duration = 0.2
        scaleAnimation.autoreverses = true
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        toggleButton.layer.add(scaleAnimation, forKey: "scaleAnimation")
        
        if isPlanetBoxVisible {
            planetBoxView.isHidden = false
            NSLayoutConstraint.deactivate([planetBoxViewLeadingHiddenConstraint])
            NSLayoutConstraint.activate([planetBoxViewLeadingVisibleConstraint])
            
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
            
            toggleButton.setTitle(NSLocalizedString("Fechar", comment: ""), for: .normal)
            toggleButton.backgroundColor = ColorCatalog.orange
        } else {
            NSLayoutConstraint.deactivate([planetBoxViewLeadingVisibleConstraint])
            NSLayoutConstraint.activate([planetBoxViewLeadingHiddenConstraint])
            
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutIfNeeded()
            }) { _ in
                self.planetBoxView.isHidden = true
            }
            
            toggleButton.setTitle(NSLocalizedString("Explore", comment: ""), for: .normal)
            toggleButton.backgroundColor = ColorCatalog.yellow
        }
    }
}
