//
//  FontManager.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 06/08/24.
//

import UIKit

// MARK: - FontManager

struct FontManager {
    
    // Fonte Regular
    static func regularFont(size: CGFloat) -> UIFont? {
        return UIFont(name: "IBMPlexSans-Regular", size: size)
    }
    
    // Fonte Bold
    static func boldFont(size: CGFloat) -> UIFont? {
        return UIFont(name: "IBMPlexSans-Bold", size: size)
    }
    
    // Fonte SemiBold
    static func mediumFont(size: CGFloat) -> UIFont? {
        return UIFont(name: "IBMPlexSans-Medium", size: size)
    }
    
}

