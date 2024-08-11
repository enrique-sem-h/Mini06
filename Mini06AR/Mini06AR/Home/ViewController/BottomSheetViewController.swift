//
//  BottomSheetViewController.swift
//  Mini06AR
//
//  Created by GABRIEL Ferreira Cardoso on 07/08/24.
//

import UIKit

/**
 `BottomSheetViewController` é um controlador de visualização que apresenta uma folha inferior (bottom sheet) customizada no aplicativo `Mini06AR`.
 Ele exibe uma mensagem de boas-vindas aos usuários e oferece botões para explorar os planetas ou visualizar o sistema solar em Realidade Aumentada.
 */
class BottomSheetViewController: UIViewController {
    
    /// Método chamado após a visualização do controlador ser carregada na memória.
    ///
    /// Este método configura a interface de usuário (UI), estiliza a folha inferior, e adiciona um handle (indicador de arrasto) na parte superior da folha.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        styleBottomSheet()
        addHandle()
    }
    
    /**
     Configura a interface de usuário da folha inferior.
     
     Este método cria uma `containerView` para conter um `UILabel` que exibe uma mensagem composta por texto e imagens.
     */
    private func setupUI() {
        let containerView = UIView()
        containerView.backgroundColor = ColorCatalog.white.withAlphaComponent(0.2)
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = FontManager.semiboldFont(size: 22)
        label.textColor = ColorCatalog.white
        
        // Cria uma mensagem com texto e imagens (botões de explorar e AR)
        let text1 = NSLocalizedString("Hello, welcome to Little Planets\n\nclick on ", comment: "")
        let explorarAttachment = NSTextAttachment()
        explorarAttachment.image = UIImage(named: "explore_Image")
        explorarAttachment.bounds = CGRect(x: 0, y: -5, width: 100, height: 30)
        let text2 = NSLocalizedString("  to look at planets and stars individually.\n\nor click the button  ", comment: "")
        let raAttachment = NSTextAttachment()
        if let image = UIImage(systemName: "arkit")?.withRenderingMode(.alwaysTemplate) {
            raAttachment.image = image
            raAttachment.image = raAttachment.image?.withTintColor(ColorCatalog.white)
        }
        raAttachment.bounds = CGRect(x: 0, y: -5, width: 30, height: 30)
        let text3 = NSLocalizedString("  to see only the solar system in Augmented Reality.", comment: "")
        
        // Monta a mensagem final com texto e imagens
        let attributedString = NSMutableAttributedString(string: text1)
        attributedString.append(NSAttributedString(attachment: explorarAttachment))
        attributedString.append(NSAttributedString(string: text2))
        attributedString.append(NSAttributedString(attachment: raAttachment))
        attributedString.append(NSAttributedString(string: text3))
        
        label.attributedText = attributedString
        containerView.addSubview(label)
        view.addSubview(containerView)
        
        // Configura as constraints do `label` dentro da `containerView`
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
        
        // Configura as constraints da `containerView` dentro da view principal
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    /**
     Estiliza a folha inferior.
     
     Este método define a cor de fundo e as bordas arredondadas da folha inferior, proporcionando uma aparência visual moderna.
     */
    private func styleBottomSheet() {
        view.backgroundColor = ColorCatalog.blue.withAlphaComponent(0.80)
        view.layer.cornerRadius = 94
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    /**
     Adiciona um handle (indicador de arrasto) na parte superior da folha inferior.
     
     O handle é um pequeno indicador visual que sugere que a folha pode ser arrastada para cima ou para baixo.
     */
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

/**
 `BottomSheetPresentationController` é uma subclasse de `UIPresentationController` que gerencia a apresentação customizada de uma folha inferior.
 
 Esta classe define a posição, tamanho e comportamento da folha inferior, incluindo a adição de uma visualização de fundo semitransparente que escurece o conteúdo abaixo da folha.
 */
class BottomSheetPresentationController: UIPresentationController {
    
    /// Visualização de fundo que escurece o conteúdo abaixo da folha inferior.
    private var dimmingView: UIView!
    
    /// Define a posição e o tamanho da folha inferior dentro da visualização do container.
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let height: CGFloat = 300 // Altura desejada da folha inferior
        return CGRect(x: 0, y: containerView.bounds.height - height, width: containerView.bounds.width, height: height)
    }
    
    /**
     Método chamado quando a transição de apresentação da folha inferior está prestes a começar.
     
     Este método adiciona uma visualização de fundo semitransparente e inicia uma animação que escurece o conteúdo abaixo da folha inferior.
     */
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let containerView = containerView else { return }
        
        dimmingView = UIView(frame: containerView.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.alpha = 0
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped)))
        containerView.addSubview(dimmingView)
        containerView.addSubview(presentedView!)
        
        UIView.animate(withDuration: 0.3) {
            self.dimmingView.alpha = 1
        }
    }
    
    /**
     Método chamado quando a transição de despedida da folha inferior está prestes a começar.
     
     Este método anima a visualização de fundo para desaparecer quando a folha inferior é dispensada.
     */
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        UIView.animate(withDuration: 0.3) {
            self.dimmingView.alpha = 0
        }
    }
    
    /**
     Ação chamada quando a visualização de fundo é tocada.
     
     Este método dispensa a folha inferior quando o usuário toca fora dela.
     */
    @objc private func dimmingViewTapped() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}

/**
 `BottomSheetTransitioningDelegate` é um objeto que implementa o protocolo `UIViewControllerTransitioningDelegate` para fornecer um controlador de apresentação customizado.
 
 Esta classe permite o uso de `BottomSheetPresentationController` para apresentar a folha inferior de maneira customizada.
 */
class BottomSheetTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    /// Retorna o controlador de apresentação customizado para a folha inferior.
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
