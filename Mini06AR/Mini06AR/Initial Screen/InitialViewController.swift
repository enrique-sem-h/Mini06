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
        setupPlayButton()
    }
    
    private func setupPlayButton() {
        playButton = UIButton(type: .system)
        playButton.setImage(UIImage(systemName: "play"), for: .normal)
        playButton.setTitle(" "+NSLocalizedString("Start", comment: ""), for: .normal)
        playButton.tintColor = .white
        playButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Bold", size: 16)
        
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
        playButton.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        playButton.clipsToBounds = true
        
        playButton.addTarget(self, action: #selector(begin), for: .touchUpInside)
    }
    
    @objc private func begin() {
        coordinator?.showHomeView()
    }
}
