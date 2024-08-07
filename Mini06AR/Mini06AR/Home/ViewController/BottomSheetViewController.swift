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
    }
    
    private func setupUI() {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "IBMPlexSans-Regular", size: 22)
        label.textColor = ColorCatalog.white
        
        // Texto antes da primeira imagem
        let text1 = "Olá, bem vindo ao PlanetARium, clique em "
        
        // Imagem "Explorar"
        let explorarAttachment = NSTextAttachment()
        explorarAttachment.image = UIImage(named: "explore_Image") // Substitua pelo nome da imagem correta
        explorarAttachment.bounds = CGRect(x: 0, y: -5, width: 70, height: 30) // Ajuste os bounds conforme necessário
        
        // Texto entre as imagens
        let text2 = " se quiser olhar planetas e astros de maneira individual ou clique no botão "
        
        // Imagem "RA"
        let raAttachment = NSTextAttachment()
        if let image = UIImage(systemName: "arkit")?.withRenderingMode(.alwaysTemplate) {
            raAttachment.image = image
            raAttachment.image = raAttachment.image?.withTintColor(ColorCatalog.white)
        } else {
            print("Erro ao carregar a imagem 'arkit'")
        }

        raAttachment.bounds = CGRect(x: 0, y: -5, width: 30, height: 30) // Ajuste os bounds conforme necessário
        // Texto após a última imagem
        let text3 = " para ver em Realidade Aumentada somente o sistema solar."
        
        // Monta o NSAttributedString combinando texto e imagens
        let attributedString = NSMutableAttributedString(string: text1)
        attributedString.append(NSAttributedString(attachment: explorarAttachment))
        attributedString.append(NSAttributedString(string: text2))
        attributedString.append(NSAttributedString(attachment: raAttachment))
        attributedString.append(NSAttributedString(string: text3))
        
        // Define o NSAttributedString no UILabel
        label.attributedText = attributedString
        
        // Adiciona o UILabel à view
        view.addSubview(label)
        
        // Configura as constraints do UILabel
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
        ])
    }

    
    private func styleBottomSheet() {
        view.backgroundColor = ColorCatalog.blue.withAlphaComponent(0.80)
        
        view.layer.cornerRadius = 94
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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

