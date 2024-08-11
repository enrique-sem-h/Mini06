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
    
    /// Closure que é chamada quando um botão de planeta é pressionado, exibindo o conteúdo de AR para o planeta selecionado.
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
     Configura os botões de seleção de planetas dentro da caixa.
     */
    private func setupPlanetSelectionButtons() {
        // Remove quaisquer botões existentes
        self.subviews.filter { $0 is UIButton }.forEach { $0.removeFromSuperview() }
        
        let buttonHeight: CGFloat = 40
        let buttonSpacing: CGFloat = 15
        let topPadding: CGFloat = 20
        
        // Carrega a imagem de fundo do botão
        guard let buttonBackgroundImage = UIImage(named: "button_image") else {
            showErrorAlert(message: "Failed to load the button background image.")
            return
        }
        
        // Cria e configura os botões para cada planeta
        for (index, planet) in planets.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(planet.name, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont(name: "Signika-Bold", size: 18)
            button.tag = index
            
            button.setBackgroundImage(buttonBackgroundImage, for: .normal)
            button.layer.cornerRadius = buttonHeight / 2
            button.clipsToBounds = true
            
            button.addTarget(self, action: #selector(planetButtonTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(button)
            
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
                button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
                button.heightAnchor.constraint(equalToConstant: buttonHeight),
                button.topAnchor.constraint(equalTo: self.topAnchor, constant: topPadding + CGFloat(index) * (buttonHeight + buttonSpacing))
            ])
        }
    }

    /**
     Método chamado quando um botão de planeta é pressionado.
     
     - Parameter sender: O botão pressionado.
     */
    @objc private func planetButtonTapped(_ sender: UIButton) {
        let planetIndex = sender.tag
        // Verifica se o índice está dentro dos limites
        guard planetIndex >= 0 && planetIndex < planets.count else {
            showErrorAlert(message: "Invalid planet index.")
            return
        }
        let selectedPlanet = planets[planetIndex]
        showARView?(selectedPlanet)
    }
    
    /**
     Exibe um alerta de erro.
     
     - Parameter message: A mensagem a ser exibida no alerta.
     */
    private func showErrorAlert(message: String) {
        // Obtém o controlador de visualização atual
        if let topController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            topController.present(alertController, animated: true, completion: nil)
        }
    }
}
