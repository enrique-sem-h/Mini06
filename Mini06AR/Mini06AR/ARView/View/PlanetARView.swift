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
 A classe `PlanetARView` é responsável por configurar a ARView com as Views de informação e controles que afetam a Realidade Aumentada.
 */
class PlanetARView: UIView {
    weak var viewController: ARViewController?
    
     lazy var isShowingInfo = false
     lazy var arView = CustomARView()
     lazy var resetButton = UIButton(type: .roundedRect)
     lazy var contentView = PassthroughView()
     lazy var infoView = UIView()
     lazy var textLabel = PaddedLabel()
    
    init(viewController: ARViewController) {
        self.viewController = viewController
        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.backgroundColor = .clear
        setupARView()
        setupResetButton()
        configureInfo()
        setupBackButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ARView Setup
    private func setupARView() {
        guard ARWorldTrackingConfiguration.isSupported else {
            showErrorAlert(message: NSLocalizedString("AR is not supported on this device.", comment: ""))
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
        if isShowingInfo {
            toggleInfo()
        }
    }
    
    private func placeResetButton() {
        arView.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetButton.centerXAnchor.constraint(equalTo: arView.centerXAnchor),
            resetButton.topAnchor.constraint(equalTo: arView.topAnchor, constant: 45)
        ])
    }
    
    // MARK: - Info Configuration
    private func configureInfo() {
        contentView.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.layer.cornerRadius = 8.0
        infoView.backgroundColor = ColorCatalog.getTextBackgroundColor(for: viewController?.planet?.name ?? "")
        
        textLabel = createPaddedLabel(
            text: (viewController?.planet?.descriptions["Curiosity 1"] ?? "") + "\n" + (viewController?.planet?.descriptions["Curiosity 2"] ?? ""),
            baseFontSize: 20,
            font: "Signika-Regular",
            padding: UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 20),
            textColor: ColorCatalog.getDescriptionTextColor(for: viewController?.planet?.name ?? "")
        )
        textLabel.numberOfLines = 0
        textLabel.layer.cornerRadius = 10
        textLabel.layer.masksToBounds = true
        textLabel.backgroundColor = ColorCatalog.white.withAlphaComponent(0.3)
        
        infoView.addSubview(textLabel)
        addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
        ])
    }
    
    // MARK: - Back Button
    private func setupBackButton() {
        guard let coordinator = viewController?.coordinator else { return }
        let backButton = BackButton(coordinator: coordinator)
        self.addSubview(backButton)
        backButton.setupRelatedToView(view: self)
    }
    
    @objc private func backButtonTap() {
        viewController?.coordinator?.navigationController.popViewController(animated: true)
    }
    
    // MARK: - Label Creation
    private func createDescriptionLabel(text: String, celestialName: String) -> PaddedLabel {
        let label = createPaddedLabel(
            text: text,
            baseFontSize: 20,
            font: "Beiruti[wght]",
            padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 20),
            textColor: ColorCatalog.getDescriptionTextColor(for: celestialName)
        )
        label.numberOfLines = 0
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.backgroundColor = ColorCatalog.white.withAlphaComponent(0.3)
        return label
    }
    
    private func createPaddedLabel(text: String?, baseFontSize: CGFloat, font: String, padding: UIEdgeInsets = .zero, textColor: UIColor) -> PaddedLabel {
        let label = PaddedLabel()
        label.text = text
        label.textColor = textColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.padding = padding
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let adjustedFont = adjustFontSizeToFit(text: text, baseFontSize: baseFontSize, font: font, label: label)
        label.font = adjustedFont
        
        return label
    }
    
    private func adjustFontSizeToFit(text: String?, baseFontSize: CGFloat, font: String, label: PaddedLabel) -> UIFont {
        guard let text = text else { return UIFont(name: font, size: baseFontSize) ?? UIFont.systemFont(ofSize: baseFontSize) }
        
        var fontSize = baseFontSize
        let maxSize = CGSize(width: label.frame.width - label.padding.left - label.padding.right, height: CGFloat.greatestFiniteMagnitude)
        
        while fontSize > 0 {
            let font = UIFont(name: font, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
            let textAttributes = [NSAttributedString.Key.font: font]
            let textSize = (text as NSString).boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: textAttributes, context: nil).size
            
            if textSize.height <= label.frame.height - label.padding.top - label.padding.bottom &&
               textSize.width <= label.frame.width - label.padding.left - label.padding.right {
                return font
            }
            
            fontSize -= 1
        }
        
        return UIFont(name: font, size: baseFontSize) ?? UIFont.systemFont(ofSize: baseFontSize)
    }
    
    // MARK: - Error Handling
    private func showErrorAlert(message: String) {
        if let topController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            topController.present(alertController, animated: true, completion: nil)
        }
    }
}

