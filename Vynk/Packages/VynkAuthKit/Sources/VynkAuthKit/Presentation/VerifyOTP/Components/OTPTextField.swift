//
//  SwiftUIView.swift
//  VynkAuthKit
//
//  Created by Vijay Thakur on 10/07/26.
//

import SwiftUI

enum OTPFieldType: Int {
    case four = 4
    case six = 6
}

struct OTPTextField: View {

    @Binding var value: String

    var type: OTPFieldType = .six

    @FocusState
    private var isFocused: Bool

    var body: some View {

        ZStack {

            // Hidden TextField
            TextField("", text: $value)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .focused($isFocused)
                .opacity(0.01)
                .frame(width: 1, height: 1)
                .onChange(of: value) { _, newValue in
                    value = String(newValue.prefix(type.rawValue))
                }

            HStack(spacing: 0) {

                ForEach(0..<(type.rawValue / 2), id: \.self) { index in
                    otpBox(index)
                }

                Spacer()
                    .frame(width: 20) // Extra gap between halves

                ForEach((type.rawValue / 2)..<type.rawValue, id: \.self) { index in
                    otpBox(index)
                }
            }
        }
        .frame(height: 50)
        .contentShape(.rect)
        .onTapGesture {
            isFocused = true
        }
    }

    @ViewBuilder
    private func otpBox(_ index: Int) -> some View {
        Rectangle()
            .fill(.clear)
            .frame(width: 40)
            .overlay {
                if let character = character(at: index) {
                    Text(String(character))
                        .font(.title2.bold())
                } else {
                    Rectangle()
                        .fill(.primary)
                        .frame(width: 24, height: 3)
                }
            }
    }

    private func character(at index: Int) -> Character? {

        guard index < value.count else {
            return nil
        }

        let stringIndex = value.index(value.startIndex, offsetBy: index)
        return value[stringIndex]
    }
}
