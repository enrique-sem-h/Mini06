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
    
    var planetNameLabel: UILabel!
    var planetDescriptionLabel: UILabel!
    var planetRadiusLabel: UILabel!
    var planetDistanceLabel: UILabel!
    var planetImageView: UIImageView!
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
        planetNameLabel = {
            let label = UILabel()
            label.text = planet?.name
            label.font = UIFont.boldSystemFont(ofSize: 24)
            label.textAlignment = .center
            label.textColor = .label
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        planetDescriptionLabel = {
            let descriptionLabel = UILabel()
            descriptionLabel.text = planet?.description
            descriptionLabel.font = UIFont.systemFont(ofSize: 16)
            descriptionLabel.textAlignment = .left
            descriptionLabel.numberOfLines = 0
            descriptionLabel.textColor = .secondaryLabel
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            return descriptionLabel
        }()
        
        planetImageView = {
            let imageView = UIImageView()
            if let imageName = planet?.imageName {
                imageView.image = UIImage(named: imageName)
            }
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        planetRadiusLabel = {
            let radiusLabel = UILabel()
            radiusLabel.text = "Raio: \(planet?.radius ?? 0) km"
            radiusLabel.font = UIFont.systemFont(ofSize: 16)
            radiusLabel.textAlignment = .center
            radiusLabel.textColor = .label
            radiusLabel.translatesAutoresizingMaskIntoConstraints = false
            return radiusLabel
        }()
        
        planetDistanceLabel = {
            let distanceLabel = UILabel()
            if planet?.name == "Sol" {
                distanceLabel.text = ""
            } else {
                distanceLabel.text = "Distância do Sol: \(planet?.distanceFromSun ?? 0) milhões de km"
            }
            distanceLabel.font = UIFont.systemFont(ofSize: 16)
            distanceLabel.textAlignment = .center
            distanceLabel.textColor = .label
            distanceLabel.translatesAutoresizingMaskIntoConstraints = false
            return distanceLabel
        }()
        
        stackView = {
            let stackView = UIStackView(arrangedSubviews: [planetNameLabel, planetDescriptionLabel, planetImageView, planetRadiusLabel, planetDistanceLabel])
            stackView.axis = .vertical
            stackView.spacing = 10
            stackView.alignment = .leading
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        setupViews()
    }
    
    private func setupViews() {
        let screenWidth = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).flatMap({ $0.windows }).first(where: { $0.isKeyWindow })?.bounds.width
        let defaultPadding = 120/0.16
        backgroundColor = .systemBackground
        addSubview(planetImageView)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            planetImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0.16 * (screenWidth ?? defaultPadding)),
            planetImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            planetImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            planetImageView.widthAnchor.constraint(equalTo: planetImageView.heightAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.2),
            stackView.leadingAnchor.constraint(equalTo: planetImageView.trailingAnchor, constant: 120),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -0.08 * (screenWidth ?? defaultPadding/2)),
        ])
    }
}
