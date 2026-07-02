//
//  ContactRowView.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI

struct DeviceContactRow: View {
    let model: DeviceContact
    let onInviteTap: (DeviceContact)->()
    var body: some View {
        Button {
            onInviteTap(model)
        } label: {
            HStack {
                if let data = model.thumbnailImageData, let uiImage = UIImage(data: data){
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: AppSizes.avatarMD, height: AppSizes.avatarMD)
                        .clipShape(.circle)
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
                    if model.fullName.isNotEmptyString {
                        Text(model.fullName)
                            .font(AppFont.bodySemibold)
                    }
                    if !model.phoneNumbers.isEmpty{
                        Text(model.phoneNumbers.joined(separator: ", "))
                            .font(model.fullName.isEmptyString ? AppFont.bodySemibold : AppFont.caption)
                            .foregroundStyle(model.fullName.isEmptyString ? AppColors.contentDefault : AppColors.contentDeemphasized)
                    }
                }
                .hSpacing(.leading)
                
                Text("Invite")
                    .font(AppFont.captionMedium)
                    .foregroundStyle(AppColors.accentEmphasized)
            }
        }

    }
}

