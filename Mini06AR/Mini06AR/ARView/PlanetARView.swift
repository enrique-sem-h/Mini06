//
//  ARView.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 22/07/24.
//

import RealityKit
import UIKit

class PlanetARView: UIView {
    weak var arViewController: ARViewController?
    
    private var detailsButton: UIButton!
//    private var stackView: UIStackView!
    
    init(arViewController: ARViewController? = nil) {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        self.arViewController = arViewController
        setupHUD()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHUD() {
        detailsButton = {
            let detailsButton = UIButton(type: .system)
//            detailsButton.setTitle("Detalhes", for: .normal)
            detailsButton.setImage(UIImage(systemName: "ellipsis.circle.fill"), for: .normal)
//            detailsButton.setTitleColor(.systemBlue, for: .normal)
            detailsButton.tintColor = .black
            detailsButton.addTarget(arViewController, action: #selector(arViewController?.showPlanetDetail), for: .touchUpInside)
            detailsButton.translatesAutoresizingMaskIntoConstraints = false
            return detailsButton
        }()

//        stackView = {
//            let stackView = UIStackView(arrangedSubviews: [detailsButton])
//            stackView.axis = .vertical
//            stackView.spacing = 10
//            stackView.alignment = .center
//            return stackView
//        }()

        self.addSubview(detailsButton)
        
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            detailsButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}
