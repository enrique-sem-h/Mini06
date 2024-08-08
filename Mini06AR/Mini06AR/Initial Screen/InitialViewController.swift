//
//  InitialView.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 07/08/24.
//

import Foundation
import UIKit
import SceneKit

class InitialViewController: UIViewController {
    var coordinator: MainCoordinator?
    
    var playButton: UIButton!
    var titleImageView: UIImageView!
    
    /**
     Chamado após a visualização do controlador ser carregada na memória.
     Configura a `HomeView` e define a ação a ser realizada quando um planeta é selecionado.
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
    
    private func setupTitleImageView() {
        titleImageView = UIImageView(image: UIImage(named: "image_logo"))
        titleImageView.contentMode = .scaleAspectFit
        view.addSubview(titleImageView)
        
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            titleImageView.widthAnchor.constraint(equalToConstant: 600),
            titleImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
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
    
    @objc private func begin() {
        coordinator?.showHomeView()
    }
}
