//
//  VynkContactRow.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

struct VynkContactRow: View {
    let model: VynkContactModel
    var body: some View {
        HStack {
            if let url = model.avatar{
                VynkRemoteImage(
                    url: .init(string: url),
                    width: AppSizes.avatarMD,
                    height: AppSizes.avatarMD,
                    shape: .circle
                )
            }else {
                Circle()
                    .fill(AppColors.neutralSubtle)
                    .frame(width: AppSizes.avatarMD, height: AppSizes.avatarMD)
                    .overlay {
                        AppSymbols.person.image
                            .foregroundStyle(AppColors.neutralMuted)
                    }
            }
            
            VStack(alignment: .leading){
                if let name = model.name, name.isNotEmptyString {
                    Text(name)
                        .font(AppFont.bodySemibold)
                }
                if let about = model.about, about.isNotEmptyString{
                    Text(about)
                        .font(AppFont.caption)
                        .foregroundStyle(AppColors.contentDeemphasized)
                }
            }
            .hSpacing(.leading)
            
        }
    }
}
