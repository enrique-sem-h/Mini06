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
        
        self.subviews.filter { $0 is UIButton }.forEach { $0.removeFromSuperview() }
        
        let buttonHeight: CGFloat = 40
        let buttonSpacing: CGFloat = 10
        
        for (index, name) in planetNames.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(name, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.tag = index
            
            button.backgroundColor = UIColor.white.withAlphaComponent(0.3)
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
            button.clipsToBounds = true
            
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = button.bounds
            blurEffectView.isUserInteractionEnabled = false
            blurEffectView.layer.cornerRadius = 10
            blurEffectView.clipsToBounds = true
            button.insertSubview(blurEffectView, at: 0)
            
            button.addTarget(self, action: #selector(planetButtonTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(button)
            
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                button.heightAnchor.constraint(equalToConstant: buttonHeight)
            ])
            
            if index == 0 {
                button.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            } else {
                let previousButton = self.subviews.filter { $0 is UIButton }[index - 1] as! UIButton
                button.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: buttonSpacing).isActive = true
            }
        }
    }
    
    @objc private func planetButtonTapped(_ sender: UIButton) {
        let planetIndex = sender.tag
        let selectedPlanet = planets[planetIndex]
        showARView?(selectedPlanet)
    }
}
