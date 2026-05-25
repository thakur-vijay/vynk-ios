//
//  String+Extensions.swift
//  Vynk
//
//  Created by Vijay Thakur on 24/05/26.
//

import Foundation
import UIKit

extension String {
    var isEmptyString: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isNotEmptyString: Bool {
        !self.isEmptyString
    }
    
    func width(usingFont font: UIFont) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [
            
            .font: font
            
        ]
        
        return self.size(withAttributes: attributes).width
        
    }
}
