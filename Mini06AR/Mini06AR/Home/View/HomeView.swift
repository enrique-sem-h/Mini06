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
    
    /// A visualização da caixa de seleção de planetas.
    private var planetBoxView: PlanetBoxView!
    
    /// O botão de alternância para mostrar/ocultar a caixa de seleção de planetas.
    private var toggleButton: UIButton!
    
    var sceneView: SolarSystemSceneView!
    
    /**
     Inicializa uma nova `HomeView` com o quadro e os planetas fornecidos.
     
     - Parameters:
        - frame: O quadro da visualização.
        - planets: Uma lista de planetas a serem exibidos.
     */
    init(frame: CGRect, planets: [Planet]) {
        self.planets = planets
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
        
        planetBoxView = PlanetBoxView(frame: CGRect(x: -200, y: 80, width: 180, height: 460), planets: planets)
        planetBoxView.isHidden = true
        planetBoxView.showARView = { [weak self] planet in
            self?.showARView?(planet)
        }
        self.addSubview(planetBoxView)
        
        setupToggleButton()
    }
    
    /**
     Configura o botão de alternância para mostrar/ocultar a caixa de seleção de planetas.
     */
    private func setupToggleButton() {
        toggleButton = UIButton(type: .system)
        toggleButton.setTitle("Menu", for: .normal)
        toggleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        toggleButton.setTitleColor(.white, for: .normal)
        
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 40
        let boxX: CGFloat = 20
        let boxY: CGFloat = planetBoxView.frame.maxY + 10
        toggleButton.frame = CGRect(x: boxX, y: boxY, width: buttonWidth, height: buttonHeight)
        
        toggleButton.layer.cornerRadius = 10
        toggleButton.layer.borderWidth = 1
        toggleButton.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        toggleButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        toggleButton.clipsToBounds = true
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.isUserInteractionEnabled = false
        blurEffectView.layer.cornerRadius = 10
        blurEffectView.clipsToBounds = true
        toggleButton.addSubview(blurEffectView)
        
        toggleButton.addTarget(self, action: #selector(togglePlanetBox), for: .touchUpInside)
        self.addSubview(toggleButton)
    }
    
    /**
     Método chamado quando o botão de alternância é pressionado, mostrando ou ocultando a caixa de seleção de planetas.
     */
    @objc private func togglePlanetBox() {
        isPlanetBoxVisible.toggle()
        
        let boxWidth: CGFloat = planetBoxView.frame.width
        let boxHeight: CGFloat = planetBoxView.frame.height
        let boxX: CGFloat = 20
        let boxY: CGFloat = 80
        
        let boxHiddenFrame = CGRect(x: -boxWidth, y: boxY, width: boxWidth, height: boxHeight) // Fora da tela à esquerda
        let boxVisibleFrame = CGRect(x: boxX, y: boxY, width: boxWidth, height: boxHeight) // Dentro da tela
        
        if isPlanetBoxVisible {
            planetBoxView.frame = boxHiddenFrame
            planetBoxView.isHidden = false
            
            UIView.animate(withDuration: 0.3, animations: {
                self.planetBoxView.frame = boxVisibleFrame
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.planetBoxView.frame = boxHiddenFrame
            }) { _ in
                self.planetBoxView.isHidden = true
            }
        }
    }
}
