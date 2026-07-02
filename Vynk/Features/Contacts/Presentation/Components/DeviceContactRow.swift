//
//  ContactRowView.swift
//  Vynk
//
//  Created by Vijay Thakur on 31/05/26.
//

import SwiftUI
import VynkFoundation

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
                        .frame(width: AppAvatarSize.md, height: AppAvatarSize.md)
                        .clipShape(.circle)
                }else {
                    Circle()
                        .fill(AppColors.neutralSubtle)
                        .frame(width: AppAvatarSize.md, height: AppAvatarSize.md)
                        .overlay {
                            AppSymbols.person.image
                                .foregroundStyle(AppColors.neutralMuted)
                        }
                }
                
                VStack(alignment: .leading){
                    if model.fullName.isNotBlank {
                        Text(model.fullName)
                            .font(AppFont.bodySemibold)
                    }
                    if !model.phoneNumbers.isEmpty{
                        Text(model.phoneNumbers.joined(separator: ", "))
                            .font(model.fullName.isBlank ? AppFont.bodySemibold : AppFont.caption)
                            .foregroundStyle(model.fullName.isBlank ? AppColors.contentDefault : AppColors.contentDeemphasized)
                    }
                }
                .fillWidth(.leading)
                
                Text("Invite")
                    .font(AppFont.captionMedium)
                    .foregroundStyle(AppColors.accentEmphasized)
            }
        }

    }
}

