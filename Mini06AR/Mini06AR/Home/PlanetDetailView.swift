//
//  PlanetDetailView.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 22/07/24.
//

import Foundation
import UIKit

class PlanetDetailView: UIView {
    var planet: Planet?
    
    var nameLabel: UILabel!
    var descriptionLabel: UILabel!
    var radiusLabel: UILabel!
    var distanceLabel: UILabel!
    var imageView: UIImageView!
    var stackView: UIStackView!
    
    init(planet: Planet) {
        super.init(frame: .zero)
        self.planet = planet
        
        self.backgroundColor = .systemBackground
        createUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUIElements() {
        nameLabel = {
            let label = UILabel()
            label.text = planet?.name
            label.font = UIFont.systemFont(ofSize: 24)
            label.textAlignment = .center
            label.textColor = .label
            return label
        }()
        
        descriptionLabel = {
            let descriptionLabel = UILabel()
            descriptionLabel.text = planet?.description
            descriptionLabel.font = UIFont.systemFont(ofSize: 16)
            descriptionLabel.textAlignment = .center
            descriptionLabel.numberOfLines = 0
            descriptionLabel.textColor = .secondaryLabel
            return descriptionLabel
        }()
        
        imageView = {
            let imageView = UIImageView()
            if let imageName = planet?.imageName {
                imageView.image = UIImage(named: imageName)
            }
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        radiusLabel = {
            let radiusLabel = UILabel()
            radiusLabel.text = "Raio: \(planet?.radius ?? 0) km"
            radiusLabel.font = UIFont.systemFont(ofSize: 16)
            radiusLabel.textAlignment = .center
            radiusLabel.textColor = .label
            return radiusLabel
        }()
        
        distanceLabel = {
            let distanceLabel = UILabel()
            if planet?.name == "Sol" {
                distanceLabel.text = ""
            } else {
                distanceLabel.text = "Distância do Sol: \(planet?.distanceFromSun ?? 0) milhões de km"
            }
            distanceLabel.font = UIFont.systemFont(ofSize: 16)
            distanceLabel.textAlignment = .center
            distanceLabel.textColor = .label
            return distanceLabel
        }()
        
        stackView = {
            let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel, imageView, radiusLabel, distanceLabel])
            stackView.axis = .vertical
            stackView.spacing = 10
            stackView.alignment = .center
            
            return stackView
        }()
        
        setupStackView()
    }
    
    private func setupStackView() {
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            imageView.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.5),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
}
