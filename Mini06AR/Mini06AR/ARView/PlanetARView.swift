//
//  ARV.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 25/07/24.
//

import UIKit
import RealityKit
import ARKit

class PlanetARView: UIView, ARSessionDelegate, ARCoachingOverlayViewDelegate {
    weak var viewController: ARViewController?
    
    lazy private var arView = ARView()
    lazy private var deleteButton = UIButton(type: .roundedRect)
    
    init(viewController: ARViewController) {
        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.viewController = viewController
        
        self.backgroundColor = .blue
        
        setupARView()
        setupDeleteButton()
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
        arView.enableTapGesture()
    }
    
    private func configureARViewSession() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        arView.session.run(configuration)
        arView.session.delegate = self
        ARView.viewController = self.viewController
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
    
    // MARK: - DeleteButton
    private func setupDeleteButton() {
        deleteButton.setTitle("Delete All", for: .normal)
        deleteButton.tintColor = .red
        deleteButton.addTarget(self, action: #selector(handleTapDelete), for: .touchUpInside)
        placeDeleteButton()
    }
    
    @objc private func handleTapDelete() {
        guard !arView.scene.anchors.isEmpty else { return }
        arView.scene.anchors.removeAll()
    }
    
    private func placeDeleteButton() {
        arView.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.centerXAnchor.constraint(equalTo: arView.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: arView.bottomAnchor, constant: -40)
        ])
    }
}

extension ARView {
    func enableTapGesture() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleARViewTap))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    static var viewController: ARViewController?
    
    @objc private func handleARViewTap(recognizer: UITapGestureRecognizer) {
        let loc = recognizer.location(in: self)
        guard let rayResult = self.ray(through: loc) else { return }
        let results = self.scene.raycast(origin: rayResult.origin, direction: rayResult.direction)
        
        if let firstResult = results.first {
            print("tap on object: \(firstResult.entity)")
        } else {
            let results = self.raycast(from: loc, allowing: .estimatedPlane, alignment: .any)
            if let first = results.first {
                var position = simd_make_float3(first.worldTransform.columns.3)
                if self.scene.anchors.first?.findEntity(named: ARView.viewController?.planet?.modelName ?? "Earth") != nil {
                    print("already have earth placed")
                    return
                }
                let planetAnchor = AnchorEntity(world: position)
                if let planetModel = try? ModelEntity.load(named: ARView.viewController?.planet?.modelName ?? "Earth") {
                    planetModel.name = ARView.viewController?.planet?.modelName ?? "Earth"
                    planetAnchor.addChild(planetModel)
                    let from = Transform(rotation: .init(angle: .pi * 2, axis: [0, 1, 0]))
                    
                    let definition = FromToByAnimation(from: from,
                                                       duration: 20,
                                                       timing: .linear,
                                                       bindTarget: .transform,
                                                       repeatMode: .repeat)
                    
                    if let animate = try? AnimationResource.generate(with: definition) {
                        planetModel.playAnimation(animate)
                    }
                }
                self.scene.addAnchor(planetAnchor)
            }
        }
        
    }
}

extension PlanetARView {
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        arView.scene.findEntity(named: "Earth")?.removeFromParent()
    }
}
