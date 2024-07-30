//
//  SolarSystemARView.swift
//  Mini06AR
//
//  Created by Fabio Freitas on 30/07/24.
//

import UIKit
import ARKit
import RealityKit

class SolarSystemARView: UIView {
    
    private var viewController: UIViewController?
    
    lazy private var arView = CustomARView()
    lazy var resetButton = UIButton()
    
    static var sunModel: String {
        return planets.filter({ $0.modelName.contains("sun")}).first?.modelName ?? "<unknown>"
    }
    static var planetModelNames: [String] {
        return planets.map({ $0.modelName }).filter({ !($0.contains("sun") || $0.contains("moon")) })
    }
    
    init(viewController: UIViewController? = nil) {
        super.init(frame: .zero)
        self.viewController = viewController
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
    }
    
    // MARK: - ARView
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
        resetButton.setTitle("Reset Position", for: .normal)
        resetButton.configuration = UIButton.Configuration.borderedTinted()
        resetButton.tintColor = .red
        resetButton.addTarget(self, action: #selector(handleTapDelete), for: .touchUpInside)
        placeResetButton()
    }
    
    @objc private func handleTapDelete() {
        guard !arView.scene.anchors.isEmpty else { return }
        arView.scene.anchors.removeAll()
    }
    
    private func placeResetButton() {
        arView.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetButton.centerXAnchor.constraint(equalTo: arView.centerXAnchor),
            resetButton.topAnchor.constraint(equalTo: arView.safeAreaLayoutGuide.topAnchor)
        ])
    }
}

