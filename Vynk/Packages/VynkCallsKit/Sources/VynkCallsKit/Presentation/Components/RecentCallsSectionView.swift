//
//  RecentCallsSectionView.swift
//  Vynk
//
//  Created by Vijay Thakur on 28/05/26.
//

import SwiftUI

struct RecentCallsSectionView: View {
    var body: some View {
        ForEach(CallRowModel.sampleList) { call in
            RecentCallRowView(model: call)
        }
    }
}

#Preview {
    RecentCallsSectionView()
}
