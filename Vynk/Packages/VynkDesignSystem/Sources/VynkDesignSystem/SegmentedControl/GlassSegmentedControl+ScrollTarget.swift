//
//  File.swift
//  VynkDesignSystem
//
//  Created by Vijay Thakur on 03/07/26.
//

import SwiftUI

@available(iOS 18.4, *)
internal struct CustomScrollTarget: ScrollTargetBehavior {
    @Binding var tabs: [GlassSegmentedControl.Tab]
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        let offset = target.rect.origin.x
        target.rect.origin.x = tabs.closestSnapPoint(offset)
    }
    
    func properties(context: PropertiesContext) -> Properties {
        var properties = Properties()
        properties.limitsScrolls = true
        return properties
    }
}

