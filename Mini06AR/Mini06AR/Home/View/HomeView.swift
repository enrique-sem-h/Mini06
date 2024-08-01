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
    var sceneView: SolarSystemSceneView
    private var planetBoxView: PlanetBoxView!
    private var toggleButton: UIButton!
    private var settingsButton: UIButton!
    private var pauseButton: UIButton!
    private var arButton: UIButton!
    private var areSettingsButtonsVisible = false
    
    private var planetBoxViewLeadingHiddenConstraint: NSLayoutConstraint!
    private var planetBoxViewLeadingVisibleConstraint: NSLayoutConstraint!
    
    init(frame: CGRect, planets: [Planet]) {
        self.planets = planets
        sceneView = SolarSystemSceneView(frame: frame, planets: planets)
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        sceneView = SolarSystemSceneView(frame: self.frame, planets: planets)
        self.addSubview(sceneView)
        
        planetBoxView = PlanetBoxView(frame: .zero, planets: planets)
        planetBoxView.isHidden = true
        planetBoxView.showARView = { [weak self] planet in
            self?.showARView?(planet)
        }
        planetBoxView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(planetBoxView)
        
        setupToggleButton()
        setupSettingsButton()
        setupPauseButton()
        setupARButton()
        
        // Configure Auto Layout constraints for planetBoxView
        planetBoxViewLeadingHiddenConstraint = planetBoxView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -250)
        planetBoxViewLeadingVisibleConstraint = planetBoxView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        
        NSLayoutConstraint.activate([
            planetBoxViewLeadingHiddenConstraint,
            planetBoxView.centerYAnchor.constraint(equalTo: self.centerYAnchor), // Center vertically
            planetBoxView.widthAnchor.constraint(equalToConstant: 200), // Adjust width as needed
            planetBoxView.heightAnchor.constraint(equalToConstant: 570) // Adjust height as needed
        ])
    }
    
    private func setupToggleButton() {
        toggleButton = UIButton(type: .system)
        toggleButton.setTitle("Explore", for: .normal)
        toggleButton.tintColor = .white
        
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(toggleButton)
        
        NSLayoutConstraint.activate([
            toggleButton.widthAnchor.constraint(equalToConstant: 100),
            toggleButton.heightAnchor.constraint(equalToConstant: 40),
            toggleButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            toggleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        toggleButton.layer.cornerRadius = 10
        toggleButton.layer.borderWidth = 1
        toggleButton.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        toggleButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        toggleButton.clipsToBounds = true
        
        toggleButton.addTarget(self, action: #selector(togglePlanetBox), for: .touchUpInside)
    }
    
    private func setupSettingsButton() {
        settingsButton = UIButton(type: .system)
        let settingsImage = UIImage(systemName: "gearshape")
        settingsButton.setImage(settingsImage, for: .normal)
        settingsButton.tintColor = .white
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            settingsButton.widthAnchor.constraint(equalToConstant: 40),
            settingsButton.heightAnchor.constraint(equalToConstant: 40),
            settingsButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            settingsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        settingsButton.addTarget(self, action: #selector(toggleSettingsButtons), for: .touchUpInside)
    }
    
    private func setupPauseButton() {
        pauseButton = UIButton(type: .system)
        let pauseImage = UIImage(systemName: "pause.fill")
        pauseButton.setImage(pauseImage, for: .normal)
        pauseButton.tintColor = .white
        
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pauseButton)
        
        NSLayoutConstraint.activate([
            pauseButton.widthAnchor.constraint(equalToConstant: 40),
            pauseButton.heightAnchor.constraint(equalToConstant: 40),
            pauseButton.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 10),
            pauseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        pauseButton.isHidden = true
        pauseButton.addTarget(self, action: #selector(pause), for: .touchUpInside)
    }
    
    private func setupARButton() {
        arButton = UIButton(type: .system)
        let arImage = UIImage(systemName: "arkit")
        arButton.setImage(arImage, for: .normal)
        arButton.tintColor = .white
        
        arButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(arButton)
        
        NSLayoutConstraint.activate([
            arButton.widthAnchor.constraint(equalToConstant: 40),
            arButton.heightAnchor.constraint(equalToConstant: 40),
            arButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            arButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        arButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        arButton.layer.cornerRadius = 20
        arButton.layer.borderWidth = 1
        arButton.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        arButton.clipsToBounds = true
        
        arButton.addTarget(self, action: #selector(openARView), for: .touchUpInside)
    }
    
    @objc private func openARView() {
        print("Abrir visualização AR")
        
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 1.0
        fadeAnimation.toValue = 0.5
        fadeAnimation.duration = 0.2
        fadeAnimation.autoreverses = true
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        arButton.layer.add(fadeAnimation, forKey: "fadeAnimation")
    }
    
    @objc private func pause() {
        sceneView.scene?.isPaused.toggle()
        let newImage = sceneView.scene?.isPaused == true ? UIImage(systemName: "play.fill") : UIImage(systemName: "pause.fill")
        pauseButton.setImage(newImage, for: .normal)
        
        let pulseAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        pulseAnimation.values = [1.0, 1.2, 1.0]
        pulseAnimation.keyTimes = [0, 0.5, 1]
        pulseAnimation.duration = 0.4
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pauseButton.layer.add(pulseAnimation, forKey: "pulseAnimation")
    }
    
    @objc private func toggleSettingsButtons() {
        areSettingsButtonsVisible.toggle()
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = 0.3
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        settingsButton.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        UIView.animate(withDuration: 0.2) {
            let alpha: CGFloat = self.areSettingsButtonsVisible ? 1.0 : 0.0
            let transform: CGAffineTransform = self.areSettingsButtonsVisible ? .identity : CGAffineTransform(scaleX: 0.5, y: 0.5)
            
            self.pauseButton.alpha = alpha
            self.pauseButton.transform = transform
            self.pauseButton.isHidden = !self.areSettingsButtonsVisible
        }
    }
    
    @objc private func togglePlanetBox() {
        isPlanetBoxVisible.toggle()
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 1.1
        scaleAnimation.duration = 0.2
        scaleAnimation.autoreverses = true
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        toggleButton.layer.add(scaleAnimation, forKey: "scaleAnimation")
        
        if isPlanetBoxVisible {
            planetBoxView.isHidden = false
            NSLayoutConstraint.deactivate([planetBoxViewLeadingHiddenConstraint])
            NSLayoutConstraint.activate([planetBoxViewLeadingVisibleConstraint])
            
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
            
            toggleButton.setTitle("Fechar", for: .normal)
        } else {
            NSLayoutConstraint.deactivate([planetBoxViewLeadingVisibleConstraint])
            NSLayoutConstraint.activate([planetBoxViewLeadingHiddenConstraint])
            
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutIfNeeded()
            }) { _ in
                self.planetBoxView.isHidden = true
            }
            
            toggleButton.setTitle("Explore", for: .normal)
        }
    }
}
