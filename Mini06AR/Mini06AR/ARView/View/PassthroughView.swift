//
//  PassthroughView.swift
//  Mini06AR
//
//  Created by Fabio Freitas on 26/07/24.
//

import UIKit

class PassthroughView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
}
