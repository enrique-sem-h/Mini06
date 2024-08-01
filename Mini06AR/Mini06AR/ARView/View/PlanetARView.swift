//
//  ARV.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 25/07/24.
//

import UIKit
import RealityKit
import ARKit

/**
 A classe `PlanetARView` é responsável por configurar a ARView com as Views de informação e controles que afetam a Realidade Aumentada
 */
class PlanetARView: UIView {
    weak var viewController: ARViewController?
    
    lazy var isShowingInfo = false
    lazy var arView = CustomARView()
    lazy var resetButton = UIButton(type: .roundedRect)
    lazy var contentView = PassthroughView()
    lazy var infoView = UIView()
    lazy var textLabel = UILabel()
    
    init(viewController: ARViewController) {
        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.viewController = viewController
        self.backgroundColor = .clear
        setupARView()
        setupResetButton()
        configureInfo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ARView
    private func setupARView() {
        guard ARWorldTrackingConfiguration.isSupported else {
            print("AR is not supported")
            return
        }
        configureARViewSession()
        placeARView()
        arView.enableControls()
    }
    
    private func configureARViewSession() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        arView.session.run(configuration)
        arView.arViewDelegate = self
        arView.arPlanetViewController = self.viewController
    }
    
    private func placeARView() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.session = arView.session
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.delegate = self
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
        if isShowingInfo {
            toggleInfo()
        }
    }
    
    private func placeResetButton() {
        arView.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetButton.centerXAnchor.constraint(equalTo: arView.centerXAnchor),
            resetButton.topAnchor.constraint(equalTo: arView.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    //MARK: - Info about the planets
    private func configureInfo() {
        contentView.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.backgroundColor = .white
        infoView.layer.cornerRadius = 8.0
        textLabel.text = (viewController?.planet?.descriptions["Curiosidade 1"] ?? "") + "\n" + (viewController?.planet?.descriptions["Curiosidade 2"] ?? "")
        textLabel.textColor = .darkText
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(textLabel)
        
        addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
        ])
    }
}

