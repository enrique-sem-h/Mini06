//
//  ARView.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 22/07/24.
//

import RealityKit
import UIKit

class ARHUDView: UIView {
    weak var arViewController: ARViewController?
    
    private var detailsButton: UIButton!
    private var clickLabel: UILabel!
    
    init(_ arViewController: ARViewController) {
        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.arViewController = arViewController
        self.backgroundColor = .clear
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
            detailsButton.tintColor = .red
            detailsButton.addTarget(arViewController, action: #selector(arViewController?.showPlanetDetail), for: .touchUpInside)
            detailsButton.translatesAutoresizingMaskIntoConstraints = false
            return detailsButton
        }()
        
        clickLabel = {
           let label = UILabel()
            label.text = "Click the screen to place: \(arViewController?.planet?.name ?? "")"
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 16)
            return label
        }()

        self.addSubview(clickLabel)
        self.addSubview(detailsButton)
        
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        clickLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
            detailsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            
            clickLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 100),
            clickLabel.centerXAnchor.constraint(equalTo: self.layoutMarginsGuide.centerXAnchor)
        ])
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let detailsButtonPoint = detailsButton.convert(point, from: self)
        if detailsButton.point(inside: detailsButtonPoint, with: event) {
            return detailsButton
        }
        self.clickLabel.removeFromSuperview()
        return nil
    }
}
