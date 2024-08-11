//
//  BackButton.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 07/08/24.
//

import Foundation
import UIKit

/**
 A classe `BackButton` é um botão personalizado usado para navegar de volta no aplicativo.
 
 Ele exibe um botão com imagem de fundo e texto customizado, e realiza uma ação para navegar de volta na pilha de view controllers quando clicado.
 */
class BackButton: UIButton {
    /// Coordenador responsável por gerenciar a navegação.
    weak var coordinator: Coordinator?
    
    /**
     Inicializa uma nova instância de `BackButton`.
     
     - Parameter coordinator: O coordenador que gerencia a navegação.
     */
    init(coordinator: Coordinator) {
        super.init(frame: CGRect(x: 0, y: 0, width: 125, height: 49))
        
        setupButton()
        self.coordinator = coordinator
    }
    
    /**
     Método requerido pelo protocolo `NSCoding`, mas não implementado, pois o `BackButton` não é usado em storyboard.
     
     - Parameter coder: O decodificador usado para criar a instância da classe a partir de um storyboard.
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Configura o estilo e as propriedades do botão, incluindo imagem de fundo, fonte e sombra do texto.
     */
    private func setupButton() {
        self.setBackgroundImage(UIImage.backButtonBG, for: .normal)
        
        let fontSize: CGFloat = 18
        let customFont = FontManager.semiboldFont(size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: customFont,
            .foregroundColor: UIColor.white,
            .shadow: NSShadow()
        ]
        
        let attributedTitle = NSAttributedString(string: NSLocalizedString("Back", comment: ""), attributes: titleAttributes)
        self.setAttributedTitle(attributedTitle, for: .normal)
        
        self.titleLabel?.shadowOffset = CGSize(width: 0, height: 4)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addTarget(self, action: #selector(pop), for: .touchUpInside)
    }
    
    /**
     Configura as restrições de layout do botão em relação a uma view.
     
     - Parameter view: A view em relação à qual as restrições serão configuradas.
     */
    func setupRelatedToView(view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
        ])
    }
    
    /**
     Ação executada ao clicar no botão, que navega de volta para a tela anterior usando o `coordinator`.
     */
    @objc private func pop() {
        coordinator?.navigationController.popViewController(animated: true)
    }
}
