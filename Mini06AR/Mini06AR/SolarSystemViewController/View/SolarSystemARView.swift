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
 A classe `SolarSystemARView` define a view que é responsavel por montar a view do Sistema Solar em realidade aumentada, suas interações e controles
 */
class SolarSystemARView: UIView {
    var isPlayingAnimation = true
    private var viewController: UIViewController?
    
    lazy private var arView = CustomARView()
    lazy private var resetButton = UIButton()
    
    static var sunModel: String {
        return planets.filter({ $0.modelName.contains("sun")}).first?.modelName ?? "<unknown>"
    }
    
    init(viewController: UIViewController? = nil) {
        super.init(frame: .zero)
        self.viewController = viewController
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ARView
    private func setup() {
        setupARView()
        setupResetButton()
    }
    
    private func setupARView() {
        guard ARWorldTrackingConfiguration.isSupported else {
            print("AR is not supported")
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
        arView.session.run(configuration)
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
    
    // MARK: - ResetButton
    private func setupResetButton() {
        resetButton.setTitle(NSLocalizedString("Reset Position", comment: ""), for: .normal)
        resetButton.configuration = UIButton.Configuration.borderedTinted()
        resetButton.tintColor = .red
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
        guard arView.scene.findEntity(named: SolarSystemARView.sunModel) != nil else { return }
        for (n, p) in SolarSystem.solarSystemPlanets.enumerated() {
            if let e = arView.scene.findEntity(named: p.modelName) {
                if isPlayingAnimation {
                    e.stopAllAnimations()
                } else {
                    let n = n + 1
                    if let a = CustomARView.createOrbitAnimation(transform: e.transform, n: n) {
                        e.playAnimation(a)
                    }
                }
            }
        }
        isPlayingAnimation.toggle()
    }
}

