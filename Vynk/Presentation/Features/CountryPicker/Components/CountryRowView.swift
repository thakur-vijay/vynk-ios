//
//  CountryRowView.swift
//  Vynk
//
//  Created by Vijay Thakur on 02/06/26.
//

import SwiftUI

struct CountryRowView: View {
    let model: CountryModel
    let isSelected: Bool
    var body: some View {
        HStack {
            Text(model.name)
            Spacer()
            Text(model.dialCode)
                .foregroundStyle(AppColors.contentDeemphasized)
            if isSelected {
                Image(systemName: AppIcons.checkmark)
                    .foregroundStyle(AppColors.accent)
            }
        }
    }
}
