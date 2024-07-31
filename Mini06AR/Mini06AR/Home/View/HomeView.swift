//
//  HomeView.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 27/07/24.
//

import UIKit

/**
 A classe `HomeView` é uma visualização personalizada que exibe uma visualização da cena do sistema solar e um menu para selecionar planetas.
 */
class HomeView: UIView {
    
    /// Indica se a caixa de seleção de planetas está visível.
    var isPlanetBoxVisible = false
    
    /// Lista de planetas a serem exibidos.
    var planets: [Planet] = []
    
    /// Closure que é chamada quando um botão de planeta é pressionado, exibindo a visualização de AR para o planeta selecionado.
    var showARView: ((Planet) -> Void)?
    
    var sceneView: SolarSystemSceneView
    
    /// A visualização da caixa de seleção de planetas.
    private var planetBoxView: PlanetBoxView!
    
    /// O botão de alternância para mostrar/ocultar a caixa de seleção de planetas.
    private var toggleButton: UIButton!
    
    /// Botão de configurações para mostrar/ocultar os botões adicionais.
    private var settingsButton: UIButton!
    
    /// Botão de alternância para mostrar/esconder animações da view.
    private var pauseButton: UIButton!
    
    /// Botão para ativar AR.
    private var arButton: UIButton!
    
    /// Indica se os botões de configuração estão visíveis.
    private var areSettingsButtonsVisible = false
    
    /**
     Inicializa uma nova `HomeView` com o quadro e os planetas fornecidos.
     
     - Parameters:
        - frame: O quadro da visualização.
        - planets: Uma lista de planetas a serem exibidos.
     */
    init(frame: CGRect, planets: [Planet]) {
        self.planets = planets
        sceneView = SolarSystemSceneView(frame: frame, planets: planets)
        super.init(frame: frame)
        setupView()
    }
    
    /**
     Inicializa uma nova `HomeView` a partir de um codificador.
     
     - Parameter coder: O codificador a ser utilizado.
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Configura a visualização inicial, incluindo a cena do sistema solar e a caixa de seleção de planetas.
     */
    private func setupView() {
        sceneView = SolarSystemSceneView(frame: self.frame, planets: planets)
        self.addSubview(sceneView)
        
        planetBoxView = PlanetBoxView(frame: CGRect(x: -300, y: 0, width: 300, height: self.frame.height), planets: planets)
        planetBoxView.isHidden = true
        planetBoxView.showARView = { [weak self] planet in
            self?.showARView?(planet)
        }
        self.addSubview(planetBoxView)
        
        setupToggleButton()
        setupSettingsButton()
        setupPauseButton()
        setupARButton()
    }
    
    /**
     Configura o botão de alternância para mostrar/ocultar a caixa de seleção de planetas.
     */
    private func setupToggleButton() {
        toggleButton = UIButton(type: .system)
        toggleButton.setTitle("Explore", for: .normal)
        toggleButton.tintColor = .white
        
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 40
        let boxX: CGFloat = 20
        let boxY: CGFloat = self.frame.height - 80 // Mover o botão para baixo
        toggleButton.frame = CGRect(x: boxX, y: boxY, width: buttonWidth, height: buttonHeight)
        
        toggleButton.layer.cornerRadius = 10
        toggleButton.layer.borderWidth = 1
        toggleButton.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        toggleButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        toggleButton.clipsToBounds = true
        
        toggleButton.addTarget(self, action: #selector(togglePlanetBox), for: .touchUpInside)
        self.addSubview(toggleButton)
    }
    
    /**
     Configura o botão de configurações para mostrar/ocultar os botões adicionais.
     */
    private func setupSettingsButton() {
        settingsButton = UIButton(type: .system)
        let settingsImage = UIImage(systemName: "gearshape")
        settingsButton.setImage(settingsImage, for: .normal)
        settingsButton.tintColor = .white
        
        settingsButton.frame = CGRect(x: self.frame.width - 60, y: 60, width: 40, height: 40)
        
        settingsButton.addTarget(self, action: #selector(toggleSettingsButtons), for: .touchUpInside)
        self.addSubview(settingsButton)
    }
    
    /**
     Configura o botão de pausa.
     */
    private func setupPauseButton() {
        pauseButton = UIButton(type: .system)
        let pauseImage = UIImage(systemName: "pause.fill")
        pauseButton.setImage(pauseImage, for: .normal)
        pauseButton.tintColor = .white
        
        pauseButton.frame = CGRect(x: settingsButton.frame.origin.x, y: settingsButton.frame.maxY + 10, width: 40, height: 40)
        pauseButton.isHidden = true // Inicialmente escondido
        
        pauseButton.addTarget(self, action: #selector(pause), for: .touchUpInside)
        self.addSubview(pauseButton)
    }
    
    /**
     Configura o botão de AR.
     */
    private func setupARButton() {
        arButton = UIButton(type: .system)
        let arImage = UIImage(systemName: "arkit")
        arButton.setImage(arImage, for: .normal)
        arButton.tintColor = .white
        
        arButton.frame = CGRect(x: self.frame.width - 60, y: self.frame.height - 80, width: 40, height: 40)
        arButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        arButton.layer.cornerRadius = 20
        arButton.layer.borderWidth = 1
        arButton.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        arButton.clipsToBounds = true
        
        arButton.addTarget(self, action: #selector(openARView), for: .touchUpInside)
        self.addSubview(arButton)
    }

    @objc private func openARView() {
        // Lógica para abrir a visualização AR
        print("Abrir visualização AR")
        
        // Animação de fade para o botão de AR
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 1.0
        fadeAnimation.toValue = 0.5
        fadeAnimation.duration = 0.2
        fadeAnimation.autoreverses = true
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        arButton.layer.add(fadeAnimation, forKey: "fadeAnimation")
    }
    
    @objc private func pause() {
        sceneView.scene?.isPaused.toggle()
        let newImage = sceneView.scene?.isPaused == true ? UIImage(systemName: "play.fill") : UIImage(systemName: "pause.fill")
        pauseButton.setImage(newImage, for: .normal)
        
        // Animação de pulso para o botão de pausa
        let pulseAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        pulseAnimation.values = [1.0, 1.2, 1.0]
        pulseAnimation.keyTimes = [0, 0.5, 1]
        pulseAnimation.duration = 0.4
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pauseButton.layer.add(pulseAnimation, forKey: "pulseAnimation")
    }
    
    
    /**
     Método chamado quando o botão de configurações é pressionado, mostrando ou ocultando os botões adicionais.
     */
    @objc private func toggleSettingsButtons() {
        areSettingsButtonsVisible.toggle()
        
        // Animação de rotação
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

        }
    }
    
    /**
     Método chamado quando o botão de alternância é pressionado, mostrando ou ocultando a caixa de seleção de planetas.
     */
    @objc private func togglePlanetBox() {
        isPlanetBoxVisible.toggle()
        
        // Animação de escala para o botão de alternância
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 1.1
        scaleAnimation.duration = 0.2
        scaleAnimation.autoreverses = true
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        toggleButton.layer.add(scaleAnimation, forKey: "scaleAnimation")
        
        let boxWidth: CGFloat = planetBoxView.frame.width
        let boxHeight: CGFloat = planetBoxView.frame.height
        let boxX: CGFloat = 0
        let boxY: CGFloat = 0
        
        let boxHiddenFrame = CGRect(x: -boxWidth, y: boxY, width: boxWidth, height: boxHeight) // Fora da tela à esquerda
        let boxVisibleFrame = CGRect(x: boxX, y: boxY, width: boxWidth, height: boxHeight) // Dentro da tela
        
        if isPlanetBoxVisible {
            planetBoxView.frame = boxHiddenFrame
            planetBoxView.isHidden = false
            
            UIView.animate(withDuration: 0.3, animations: {
                self.planetBoxView.frame = boxVisibleFrame
            })
            
            toggleButton.setTitle("Fechar", for: .normal)
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.planetBoxView.frame = boxHiddenFrame
            }) { _ in
                self.planetBoxView.isHidden = true
            }
            
            toggleButton.setTitle("Explore", for: .normal)
        }
    }
}
