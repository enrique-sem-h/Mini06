////
////  ARView.swift
////  Mini06AR
////
////  Created by Enrique Carvalho on 22/07/24.
////
//
//import RealityKit
//import UIKit
//
///**
// A classe `ARHUDView` constrói uma View que possui elementos de interação que não interagem com a Realidade Aumentada
// */
//class ARHUDView: UIView {
//    weak var arViewController: ARViewController?
//    
//    private lazy var detailsButton = UIButton()
//    private lazy var clickLabel = UILabel()
//    
//    init(_ arViewController: ARViewController) {
//        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
//        self.arViewController = arViewController
//        self.backgroundColor = .clear
//        setupHUD()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupHUD() {
//        
//        detailsButton = {
//            let detailsButton = UIButton(type: .system)
//            detailsButton.setImage(UIImage(systemName: "arrowshape.right.fill"), for: .normal)
//            detailsButton.tintColor = ColorCatalog.white
//            detailsButton.addTarget(arViewController, action: #selector(arViewController?.showPlanetDetail), for: .touchUpInside)
//            detailsButton.translatesAutoresizingMaskIntoConstraints = false
//            
//            let blurEffect = UIBlurEffect(style: .light)
//            let blurEffectView = UIVisualEffectView(effect: blurEffect)
//            blurEffectView.isUserInteractionEnabled = false
//            blurEffectView.layer.cornerRadius = 15
//            blurEffectView.clipsToBounds = true
//            blurEffectView.backgroundColor = ColorCatalog.blue
//            
//            blurEffectView.translatesAutoresizingMaskIntoConstraints = false
//            detailsButton.insertSubview(blurEffectView, belowSubview: detailsButton.imageView!)
//            
//            NSLayoutConstraint.activate([
//                blurEffectView.leadingAnchor.constraint(equalTo: detailsButton.leadingAnchor, constant: -20),
//                blurEffectView.trailingAnchor.constraint(equalTo: detailsButton.trailingAnchor, constant: 20),
//                blurEffectView.topAnchor.constraint(equalTo: detailsButton.topAnchor, constant: -20),
//                blurEffectView.bottomAnchor.constraint(equalTo: detailsButton.bottomAnchor, constant: 20)
//            ])
//            
//            return detailsButton
//        }()
//        
//        clickLabel = {
//            let label = UILabel()
//            label.text = NSLocalizedString("Click the screen to place:  ", comment: "") + (arViewController?.planet?.name ?? "")
//            label.textColor = .white
//            
//            let fontSize: CGFloat = 16
//            label.font = FontManager.regularFont(size: fontSize)
//            
//            return label
//        }()
//        
//        self.addSubview(clickLabel)
//        self.addSubview(detailsButton)
//        
//        detailsButton.translatesAutoresizingMaskIntoConstraints = false
//        clickLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            detailsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
//            detailsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
//            
//            clickLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 100),
//            clickLabel.centerXAnchor.constraint(equalTo: self.layoutMarginsGuide.centerXAnchor)
//        ])
//    }
//    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        let detailsButtonPoint = detailsButton.convert(point, from: self)
//        if detailsButton.point(inside: detailsButtonPoint, with: event) {
//            return detailsButton
//        }
//        self.clickLabel.removeFromSuperview()
//        return nil
//    }
//}
