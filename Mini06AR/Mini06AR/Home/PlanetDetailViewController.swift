//
//  PlanetDetailViewController.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 19/07/24.
//

import UIKit

/**
 The `PlanetDetailViewController` class displays the details of a specific planet.
 */
class PlanetDetailViewController: UIViewController {
    /// The coordinator responsible for managing navigation from this screen.
    var coordinator: PlanetDetailCoordinator?
    
    /// The planet whose details will be displayed.
    var planet: Planet?

    /**
     Configures the view when the screen is loaded.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.text = planet?.name
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .label
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = planet?.description
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .secondaryLabel
        
        let imageView = UIImageView()
        if let imageName = planet?.imageName {
            imageView.image = UIImage(named: imageName)
        }
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let radiusLabel = UILabel()
        radiusLabel.text = "Raio: \(planet?.radius ?? 0) km"
        radiusLabel.font = UIFont.systemFont(ofSize: 16)
        radiusLabel.textAlignment = .center
        radiusLabel.textColor = .label
        
        let distanceLabel = UILabel()
        if planet?.name == "Sol" {
            distanceLabel.text = "Distância: N/A"
        } else {
            distanceLabel.text = "Distância do Sol: \(planet?.distanceFromSun ?? 0) milhões de km"
        }
        distanceLabel.font = UIFont.systemFont(ofSize: 16)
        distanceLabel.textAlignment = .center
        distanceLabel.textColor = .label
        
        let stackView = UIStackView(arrangedSubviews: [label, descriptionLabel, imageView, radiusLabel, distanceLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Constraints for imageView to handle image size issues
            imageView.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.5),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
}
