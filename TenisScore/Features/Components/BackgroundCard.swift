//
//  BackgroundCard.swift
//  TenisScore
//
//  Created by Vinicius de Brito on 25/11/26.
//

import SwiftUI

public struct LiquidGlassCard<Content: View>: View {
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        let shape = RoundedRectangle(cornerRadius: 30, style: .continuous)

        content
            .glassEffect(.regular, in: shape)
            .overlay {
                shape
                    .strokeBorder(Color.white.opacity(0.16), lineWidth: 1)
            }
    }
}

#Preview {
    ZStack {
        Color(white: 0.1)
            .ignoresSafeArea()

        LiquidGlassCard {
            Text("Exemplo de Card")
                .foregroundStyle(.white)
        }
        .frame(width: 361, height: 436)
    }
}
