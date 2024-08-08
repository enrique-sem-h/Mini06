//
//  BackButton.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 07/08/24.
//

import Foundation
import UIKit

class BackButton: UIButton {
    weak var coordinator: Coordinator?
    
    init(coordinator: Coordinator) {
        super.init(frame: CGRect(x: 0, y: 0, width: 125, height: 49))
        
        setupButton()
        self.coordinator = coordinator
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.setBackgroundImage(UIImage.backButtonBG, for: .normal)
        self.setTitle("Voltar", for: .normal)
        self.titleLabel?.shadowOffset = CGSize(width: 0, height: 4)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addTarget(self, action: #selector(pop), for: .touchUpInside)
    }
    
    func setupRelatedToView(view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
        ])
    }
    
    @objc private func pop() {
        coordinator?.navigationController.popViewController(animated: true)
    }
}
