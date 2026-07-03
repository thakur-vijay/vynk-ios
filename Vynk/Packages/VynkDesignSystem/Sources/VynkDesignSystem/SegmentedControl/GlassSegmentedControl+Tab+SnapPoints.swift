//
//  File.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 03/07/26.
//

import Foundation


@available(iOS 18.4, *)
internal extension [GlassSegmentedControl.Tab] {
    var snapPoints: [CGFloat] {
        var snapPoints: [CGFloat] = []
        var x: CGFloat = 0
        for tab in self {
            snapPoints.append(x + tab.viewSize.width / 2)
            x += tab.viewSize.width
        }
        
        return snapPoints
    }
    
    func closestSnapPoint(_ offset: CGFloat)-> CGFloat {
        snapPoints.min {
            abs($0 - offset) < abs($1 - offset)
        } ?? offset
    }
    
    func closestSnapPointIndex(_ offset: CGFloat)-> Int? {
        if let (index, _) = snapPoints.enumerated().min(by: {
            abs($0.element - offset) < abs($1.element - offset)
        }) {
            return index
        }
        
        return nil
    }
}
