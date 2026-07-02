//
//  String+Extensions.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/05/26.
//

import Foundation
import UIKit

public extension String {
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isNotBlank: Bool {
        !self.isBlank
    }
    
    func width(usingFont font: UIFont) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [
            
            .font: font
            
        ]
        
        return self.size(withAttributes: attributes).width
        
    }
}
