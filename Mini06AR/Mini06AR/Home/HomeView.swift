//
//  HomeView.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 27/07/24.
//

import UIKit

class HomeView: UIView {
    
    var isPlanetBoxVisible = false
    var planets: [Planet] = []
    var showARView: ((Planet) -> Void)?
    private var planetBoxView: PlanetBoxView!
    private var toggleButton: UIButton!
    
    init(frame: CGRect, planets: [Planet]) {
        self.planets = planets
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let sceneView = SolarSystemSceneView(frame: self.frame, planets: planets)
        self.addSubview(sceneView)
        
        planetBoxView = PlanetBoxView(frame: CGRect(x: -200, y: 80, width: 180, height: 460), planets: planets)
        planetBoxView.isHidden = true
        planetBoxView.showARView = { [weak self] planet in
            self?.showARView?(planet)
        }
        self.addSubview(planetBoxView)
        
        setupToggleButton()
    }
    
    private func setupToggleButton() {
        toggleButton = UIButton(type: .system)
        toggleButton.setTitle("Menu", for: .normal)
        toggleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        toggleButton.setTitleColor(.white, for: .normal)
        
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 40
        let boxX: CGFloat = 20
        let boxY: CGFloat = planetBoxView.frame.maxY + 10
        toggleButton.frame = CGRect(x: boxX, y: boxY, width: buttonWidth, height: buttonHeight)
        
        toggleButton.layer.cornerRadius = 10
        toggleButton.layer.borderWidth = 1
        toggleButton.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        toggleButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        toggleButton.clipsToBounds = true
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.isUserInteractionEnabled = false
        blurEffectView.layer.cornerRadius = 10
        blurEffectView.clipsToBounds = true
        toggleButton.addSubview(blurEffectView)
        
        toggleButton.addTarget(self, action: #selector(togglePlanetBox), for: .touchUpInside)
        self.addSubview(toggleButton)
    }
    
    @objc private func togglePlanetBox() {
        isPlanetBoxVisible.toggle()
        
        let boxWidth: CGFloat = planetBoxView.frame.width
        let boxHeight: CGFloat = planetBoxView.frame.height
        let boxX: CGFloat = 20
        let boxY: CGFloat = 80
        
        let boxHiddenFrame = CGRect(x: -boxWidth, y: boxY, width: boxWidth, height: boxHeight) // Fora da tela à esquerda
        let boxVisibleFrame = CGRect(x: boxX, y: boxY, width: boxWidth, height: boxHeight) // Dentro da tela
        
        if isPlanetBoxVisible {
            planetBoxView.frame = boxHiddenFrame
            planetBoxView.isHidden = false
            
            UIView.animate(withDuration: 0.3, animations: {
                self.planetBoxView.frame = boxVisibleFrame
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.planetBoxView.frame = boxHiddenFrame
            }) { _ in
                self.planetBoxView.isHidden = true
            }
        }
    }
}
