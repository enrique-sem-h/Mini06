//
//  PaddedLabel.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 06/08/24.
//

import Foundation
import UIKit

/**
 A `PaddedLabel` é uma subclasse personalizada de `UILabel` que permite adicionar preenchimento (padding) ao texto exibido.

 O preenchimento é adicionado dentro do rótulo, ajustando tanto a área de desenho do texto quanto o tamanho intrínseco do rótulo.
 */
class PaddedLabel: UILabel {
    /// As margens de preenchimento ao redor do texto no rótulo.
    var padding: UIEdgeInsets = .zero
    
    /**
     Desenha o texto dentro do rótulo considerando o preenchimento definido.
     
     - Parameter rect: O retângulo que define a área de desenho do texto.
     */
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: padding.top, left: padding.left, bottom: padding.bottom, right: padding.right)
        super.drawText(in: rect.inset(by: insets))
    }
    
    /**
     Calcula e retorna o tamanho intrínseco do rótulo, levando em consideração o preenchimento.
     
     - Returns: O tamanho intrínseco ajustado do rótulo.
     */
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let width = size.width + padding.left + padding.right
        let height = size.height + padding.top + padding.bottom
        return CGSize(width: width, height: height)
    }
}
