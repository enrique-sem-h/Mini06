//
//  BottomSheetViewController.swift
//  Mini06AR
//
//  Created by GABRIEL Ferreira Cardoso on 07/08/24.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        styleBottomSheet()
        addHandle()
    }
    
    private func setupUI() {
        // Cria a UIView que vai envolver o UILabel
        let containerView = UIView()
        containerView.backgroundColor = ColorCatalog.white.withAlphaComponent(0.2) // Cor da box
        containerView.layer.cornerRadius = 12 // Define as bordas arredondadas
        containerView.layer.masksToBounds = true
        
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = FontManager.semiboldFont(size: 22)
        label.textColor = ColorCatalog.white
        
        // Texto antes da primeira imagem
        let text1 = "Hello, welcome to Planetarium\n\nclick on "
        
        // Imagem "Explorar"
        let explorarAttachment = NSTextAttachment()
        explorarAttachment.image = UIImage(named: "explore_Image")
        explorarAttachment.bounds = CGRect(x: 0, y: -5, width: 100, height: 30)
        
        // Texto entre as imagens
        let text2 = "  to look at planets and stars individually.\n\nor click the button  "
        
        // Imagem "RA"
        let raAttachment = NSTextAttachment()
        if let image = UIImage(systemName: "arkit")?.withRenderingMode(.alwaysTemplate) {
            raAttachment.image = image
            raAttachment.image = raAttachment.image?.withTintColor(ColorCatalog.white)
        } else {
            print("Erro ao carregar a imagem 'arkit'")
        }
        
        raAttachment.bounds = CGRect(x: 0, y: -5, width: 30, height: 30)
        let text3 = "  to see only the solar system in Augmented Reality."
        
        // Monta o NSAttributedString combinando texto e imagens
        let attributedString = NSMutableAttributedString(string: text1)
        attributedString.append(NSAttributedString(attachment: explorarAttachment))
        attributedString.append(NSAttributedString(string: text2))
        attributedString.append(NSAttributedString(attachment: raAttachment))
        attributedString.append(NSAttributedString(string: text3))
        
        // Define o NSAttributedString no UILabel
        label.attributedText = attributedString
        
        // Adiciona o UILabel à containerView
        containerView.addSubview(label)
        
        // Adiciona a containerView à view principal
        view.addSubview(containerView)
        
        // Configura as constraints do UILabel dentro da containerView
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func styleBottomSheet() {
        view.backgroundColor = ColorCatalog.blue.withAlphaComponent(0.80)
        
        view.layer.cornerRadius = 94
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func addHandle() {
        let handleView = UIView()
        handleView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        handleView.layer.cornerRadius = 3
        
        view.addSubview(handleView)
        
        // Configura as constraints do handle
        handleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            handleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            handleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            handleView.widthAnchor.constraint(equalToConstant: 40),
            handleView.heightAnchor.constraint(equalToConstant: 6)
        ])
    }
}

class BottomSheetPresentationController: UIPresentationController {
    
    private var dimmingView: UIView!
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        
        let height: CGFloat = 300 // Defina a altura desejada
        return CGRect(x: 0, y: containerView.bounds.height - height, width: containerView.bounds.width, height: height)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        guard let containerView = containerView else { return }
        
        // Adiciona uma visualização de fundo semitransparente
        dimmingView = UIView(frame: containerView.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.alpha = 0
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped)))
        containerView.addSubview(dimmingView)
        
        containerView.addSubview(presentedView!)
        
        // Configura a animação de transição
        UIView.animate(withDuration: 0.3) {
            self.dimmingView.alpha = 1
        }
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        // Anima a visualização de fundo para desaparecer
        UIView.animate(withDuration: 0.3) {
            self.dimmingView.alpha = 0
        }
    }
    
    @objc private func dimmingViewTapped() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}

class BottomSheetTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
