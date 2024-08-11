//
//  PlanetDetailViewController.swift
//  Mini06AR
//
//  Created by Enrique Carvalho on 19/07/24.
//

import UIKit

/**
 A classe `PlanetDetailViewController` é responsável por exibir os detalhes de um planeta específico no aplicativo `Mini06AR`.
 
 Esta classe utiliza uma instância de `PlanetDetailView` para exibir as informações sobre o planeta e inclui um botão de retorno para navegar de volta à visualização anterior.
 */
class PlanetDetailViewController: UIViewController {
    /// O coordenador responsável pela navegação a partir deste controlador de visualização.
    var coordinator: PlanetDetailCoordinator?
    
    /// O planeta cujos detalhes serão exibidos.
    var planet: Planet?
    
    /// A visualização que exibe os detalhes do planeta.
    var planetDetailView: PlanetDetailView?
   
    /**
     Método chamado após a visualização do controlador ser carregada na memória.
     
     Se um objeto `Planet` estiver disponível, ele inicializa a `PlanetDetailView` com os detalhes do planeta.
     Além disso, este método configura a cor de fundo da visualização e adiciona o botão de retorno.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inicializa a `planetDetailView` com o planeta, se disponível
        if let planet = self.planet {
            planetDetailView = PlanetDetailView(planet: planet)
        }
        
        self.view.backgroundColor = .systemBackground
        
        // Define a visualização principal como `planetDetailView`
        self.view = planetDetailView
        setupBackButton()
    }
    
    /**
     Configura o botão de retorno na visualização.
     
     Este método cria e posiciona um botão de retorno (`BackButton`) que utiliza o coordenador para realizar a navegação de volta.
     */
    private func setupBackButton() {
        guard let coordinator = coordinator else { return }
        
        // Inicializa e configura o botão de retorno
        lazy var backButton = BackButton(coordinator: coordinator)
        view.addSubview(backButton)
        backButton.setupRelatedToView(view: view)
    }
}
