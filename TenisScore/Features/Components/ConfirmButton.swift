//
//  BottonConfirm.swift
//  TenisScore
//
//  Created by Vinicius de Brito on 26/11/26.
//

import SwiftUI

public struct ConfirmButton: View {
    private let title: String
    private let action: () -> Void


    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text(title)
                    .font(.body.weight(.medium))
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(.btnBackground, in: Capsule())
            .glassEffect(.regular.tint(.btnBackground), in: Capsule())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        Color(white: 0.9)
            .ignoresSafeArea()

        ConfirmButton("Iniciar primeiro game") {
            print("Botão pressionado")
        }
        .frame(width: 359)
    }
}
