//
//  InitialView.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 07/08/24.
//

import Foundation
import UIKit
import SceneKit

/**
 `InitialViewController` é o controlador de visualização inicial para o aplicativo `Mini06AR`. Ele exibe uma tela inicial com uma visão animada do sistema solar e um botão para começar a navegação no aplicativo.
 */
class InitialViewController: UIViewController {
    /// Coordenador responsável pela navegação entre as telas do aplicativo.
    var coordinator: MainCoordinator?
    
    /// Botão que inicia a navegação no aplicativo.
    var playButton: UIButton!
    
    /// Imagem do título exibida na tela inicial.
    var titleImageView: UIImageView!
    
    /**
     Método chamado após a visualização do controlador ser carregada na memória.
     
     Este método configura a `HomeView` com uma cena do sistema solar e define a ação a ser realizada quando o botão de início (`playButton`) é pressionado.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sceneView = SolarSystemSceneView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), planets: planets)
        sceneView.allowsCameraControl = false
        sceneView.cameraNode.position = SCNVector3(0, 20, 50)
        sceneView.cameraNode.look(at: sceneView.scene?.rootNode.position ?? .init(0, 0, 0))
        
        self.view = sceneView
        setupTitleImageView()
        setupPlayButton()
    }
    
    /**
     Configura a `titleImageView` com uma imagem do logotipo e define suas restrições de layout.
     
     - Note: Esta imagem é posicionada no topo da tela inicial e redimensionada proporcionalmente.
     */
    private func setupTitleImageView() {
        titleImageView = UIImageView(image: UIImage(named: "image_logo"))
        titleImageView.contentMode = .scaleAspectFit
        view.addSubview(titleImageView)
        
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleImageView.widthAnchor.constraint(equalToConstant: 700),
            titleImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    /**
     Configura o `playButton` para iniciar o aplicativo.
     
     O botão é estilizado com um ícone de play, título, cor de fundo azul e borda branca. Ele é posicionado no centro inferior da tela inicial.
     */
    private func setupPlayButton() {
        playButton = UIButton(type: .system)
        playButton.setImage(UIImage(systemName: "play"), for: .normal)
        playButton.setTitle(" Start", for: .normal)
        playButton.tintColor = ColorCatalog.white
        playButton.titleLabel?.font = FontManager.semiboldFont(size: 16)
        
        view.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.widthAnchor.constraint(equalToConstant: 150),
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
        ])

        playButton.layer.cornerRadius = 10
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.backgroundColor = ColorCatalog.blue
        playButton.clipsToBounds = true
        
        playButton.addTarget(self, action: #selector(begin), for: .touchUpInside)
    }
    
    /**
     Ação chamada quando o `playButton` é pressionado.
     
     Este método instrui o coordenador a exibir a `HomeView`.
     */
    @objc private func begin() {
        coordinator?.showHomeView()
    }
}
