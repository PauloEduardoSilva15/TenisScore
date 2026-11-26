//
//  Home.swift
//  TenisScore
//
//  Created by Igor Carrasco on 23/11/26.
//

import SwiftUI

struct Home: View {
    @Environment(AppRouter.self) private var router
    
    var body: some View {
        VStack {
//            AppBackgroundImg()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            Button("Criar partida") {
                router.push(.newMatchView)
            }
        }
    }
}

#Preview {
    NavigationView {
        Home()
    }
    .environment(AppRouter())
}
