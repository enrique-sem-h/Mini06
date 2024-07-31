//
//  PlanetBoxView.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 27/07/24.
//

import UIKit

/**
 A classe `PlanetBoxView` é uma visualização personalizada que exibe uma caixa com botões para selecionar planetas, aplicando o estilo de Glassmorphism.
 */
class PlanetBoxView: UIView {
    
    /// Closure que é chamada quando um botão de planeta é pressionado, exibindo a visualização de AR para o planeta selecionado.
    var showARView: ((Planet) -> Void)?
    
    /// Lista de planetas a serem exibidos na caixa de seleção.
    private var planets: [Planet]
    
    /**
     Inicializa uma nova `PlanetBoxView` com o quadro e os planetas fornecidos.
     
     - Parameters:
        - frame: O quadro da visualização.
        - planets: Uma lista de planetas a serem exibidos na caixa de seleção.
     */
    init(frame: CGRect, planets: [Planet]) {
        self.planets = planets
        super.init(frame: frame)
        setupGlassmorphismBox()
        setupPlanetSelectionButtons()
    }
    
    /**
     Inicializa uma nova `PlanetBoxView` a partir de um codificador.
     
     - Parameter coder: O codificador a ser utilizado.
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Configura a aparência de Glassmorphism da caixa.
     */
    private func setupGlassmorphismBox() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        self.clipsToBounds = true
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.isUserInteractionEnabled = false
        blurEffectView.layer.cornerRadius = 15
        blurEffectView.clipsToBounds = true
        self.addSubview(blurEffectView)
    }
    
    /**
     Configura os botões de seleção de planetas dentro da caixa.
     */
    private func setupPlanetSelectionButtons() {
        let planetNames = planets.map { $0.name }
        
        // Remove qualquer botão existente antes de adicionar novos botões
        self.subviews.filter { $0 is UIButton }.forEach { $0.removeFromSuperview() }
        
        let buttonHeight: CGFloat = 60 // Aumentado o tamanho do botão
        let buttonSpacing: CGFloat = 20 // Aumentado o espaçamento entre botões
        let topPadding: CGFloat = 30 // Padding na parte superior da caixa
        
        for (index, name) in planetNames.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(name, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.tag = index
            
            button.backgroundColor = UIColor.white.withAlphaComponent(0.3)
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
            button.clipsToBounds = true
            
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = button.bounds
            blurEffectView.isUserInteractionEnabled = false
            blurEffectView.layer.cornerRadius = 10
            blurEffectView.clipsToBounds = true
            button.insertSubview(blurEffectView, at: 0)
            
            button.addTarget(self, action: #selector(planetButtonTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(button)
            
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                button.heightAnchor.constraint(equalToConstant: buttonHeight)
            ])
            
            if index == 0 {
                button.topAnchor.constraint(equalTo: self.topAnchor, constant: topPadding).isActive = true
            } else {
                let previousButton = self.subviews.filter { $0 is UIButton }[index - 1] as! UIButton
                button.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: buttonSpacing).isActive = true
            }
        }
    }
    
    /**
     Método chamado quando um botão de planeta é pressionado.
     
     - Parameter sender: O botão pressionado.
     */
    @objc private func planetButtonTapped(_ sender: UIButton) {
        let planetIndex = sender.tag
        let selectedPlanet = planets[planetIndex]
        showARView?(selectedPlanet)
    }
}
