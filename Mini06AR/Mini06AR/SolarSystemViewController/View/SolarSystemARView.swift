//
//  SolarSystemARView.swift
//  Mini06AR
//
//  Created by Fabio Freitas on 30/07/24.
//

import UIKit
import ARKit
import RealityKit

/**
 A classe `SolarSystemARView` define a view que é responsável por montar a view do Sistema Solar em realidade aumentada, suas interações e controles.
 */
class SolarSystemARView: UIView {
    var isPlayingAnimation = true
    private var viewController: SolarSystemViewController?
    
    lazy var arView = CustomARView()
    lazy private var resetButton = UIButton()
    
    static var sunModel: String {
        return planets.filter({ $0.modelName.contains("sun") }).first?.modelName ?? "<unknown>"
    }
    
    init(viewController: SolarSystemViewController? = nil) {
        self.viewController = viewController
        super.init(frame: .zero)
        setup()
        setupBackButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ARView Setup
    private func setup() {
        setupARView()
        setupResetButton()
    }
    
    private func setupARView() {
        guard ARWorldTrackingConfiguration.isSupported else {
            showErrorAlert(message: "AR is not supported on this device.")
            return
        }
        configureARViewSession()
        placeARView()
        arView.enableSolarSystemGesture()
        arView.arViewDelegate = self
    }
    
    private func configureARViewSession() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        arView.session.run(configuration, options: [.removeExistingAnchors, .stopTrackedRaycasts])
    }
    
    private func placeARView() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.session = arView.session
        coachingOverlay.goal = .horizontalPlane
        self.addSubview(arView)
        self.addSubview(coachingOverlay)
        
        arView.translatesAutoresizingMaskIntoConstraints = false
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            arView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            arView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            arView.widthAnchor.constraint(equalTo: self.widthAnchor),
            arView.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            coachingOverlay.centerXAnchor.constraint(equalTo: arView.centerXAnchor),
            coachingOverlay.centerYAnchor.constraint(equalTo: arView.centerYAnchor),
            coachingOverlay.widthAnchor.constraint(equalTo: arView.widthAnchor),
            coachingOverlay.heightAnchor.constraint(equalTo: arView.heightAnchor)
        ])
    }
    
    // MARK: - Reset Button
    private func setupResetButton() {
        resetButton.setBackgroundImage(.resetButtonbg, for: .normal)
        resetButton.setTitle(NSLocalizedString("Reset", comment: ""), for: .normal)
        resetButton.setTitleColor(ColorCatalog.white, for: .normal)
        resetButton.addTarget(self, action: #selector(handleTapDelete), for: .touchUpInside)
        placeResetButton()
    }
    
    @objc private func handleTapDelete() {
        guard !arView.scene.anchors.isEmpty else { return }
        arView.scene.anchors.removeAll()
        isPlayingAnimation = false
    }
    
    private func placeResetButton() {
        arView.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetButton.bottomAnchor.constraint(equalTo: arView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            resetButton.trailingAnchor.constraint(equalTo: arView.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
    }
    
    // MARK: - Animations
    func togglePlanetAnimations() {
        guard arView.scene.findEntity(named: SolarSystemARView.sunModel) != nil else {
            showErrorAlert(message: "Sun model not found in the scene.")
            return
        }
        
        for (index, planet) in SolarSystem.solarSystemPlanets.enumerated() {
            if let entity = arView.scene.findEntity(named: planet.modelName) {
                if isPlayingAnimation {
                    entity.stopAllAnimations()
                } else {
                    let adjustedIndex = index + 1
                    if let animation = CustomARView.createOrbitAnimation(transform: entity.transform, n: adjustedIndex) {
                        entity.playAnimation(animation)
                    }
                }
            }
        }
        isPlayingAnimation.toggle()
    }
    
    private func setupBackButton() {
        guard let coordinator = viewController?.coordinator else { return }
        let backButton = BackButton(coordinator: coordinator)
        self.addSubview(backButton)
        backButton.setupRelatedToView(view: self)
    }
    
    /**
     Exibe um alerta de erro.
     
     - Parameter message: A mensagem a ser exibida no alerta.
     */
    private func showErrorAlert(message: String) {
        if let topController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            topController.present(alertController, animated: true, completion: nil)
        }
    }
}


