//
//  PlanetBoxView.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 27/07/24.
//

import UIKit

class PlanetBoxView: UIView {
    
    var showARView: ((Planet) -> Void)?
    private var planets: [Planet]
    
    init(frame: CGRect, planets: [Planet]) {
        self.planets = planets
        super.init(frame: frame)
        setupGlassmorphismBox()
        setupPlanetSelectionButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGlassmorphismBox() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        self.clipsToBounds = true
        
        // Add blur effect to box
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.isUserInteractionEnabled = false
        blurEffectView.layer.cornerRadius = 15
        blurEffectView.clipsToBounds = true
        self.addSubview(blurEffectView)
    }
    
    private func setupPlanetSelectionButtons() {
        let planetNames = planets.map { $0.name }
        let buttonWidth: CGFloat = self.frame.width - 20
        let buttonHeight: CGFloat = 40
        
        for (index, name) in planetNames.enumerated() {
            let button = UIButton(frame: CGRect(x: 10, y: 10 + index * Int(buttonHeight + 10), width: Int(buttonWidth), height: Int(buttonHeight)))
            button.setTitle(name, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.tag = index
            
            // Set glassmorphism style
            button.backgroundColor = UIColor.white.withAlphaComponent(0.3)
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
            button.clipsToBounds = true
            
            // Add blur effect to button
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = button.bounds
            blurEffectView.isUserInteractionEnabled = false
            blurEffectView.layer.cornerRadius = 10
            blurEffectView.clipsToBounds = true
            button.insertSubview(blurEffectView, at: 0)
            
            button.addTarget(self, action: #selector(planetButtonTapped(_:)), for: .touchUpInside)
            self.addSubview(button)
        }
    }
    
    @objc private func planetButtonTapped(_ sender: UIButton) {
        let planetIndex = sender.tag
        let selectedPlanet = planets[planetIndex]
        showARView?(selectedPlanet)
    }
}
