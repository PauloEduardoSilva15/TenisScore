//
//  Home.swift
//  TenisScore
//
//  Created by Igor Carrasco on 23/11/26.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(AppRouter.self) private var router

    #warning("Faz sentido uma query se eu já estou observando um contexto? Logo não preciso importar SwiftData aqui (e em nenhuma outra view)")
    @Query private var matches: [Match]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        ZStack {
            AppBackgroundImg(Image("AppBackgroundImg"))
                .allowsHitTesting(false)

            ScrollView {
                ForEach(matches) { match in
                    MatchViewComponent(match: match)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                modelContext.delete(match)
                            } label: {
                                Label("Excluir", systemImage: "trash")
                            }
                        }
                }
            }
            .swipeActionsContainer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    router.push(.newMatchView)
//                    do {
//                        modelContext.insert(
//                            try Match(
//                                players: [
//                                    Player(name: "Nome 1"), Player(name: "Nome 2"),
//                                ],
//                                playerQuantity: .singles,
//                                setQuantity: .three
//                            )
//                        )
//                    } catch {
//                        print(error.localizedDescription)
//                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationTitle("Jogos anteriores")
        .toolbarTitleDisplayMode(.inlineLarge)
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
    .environment(AppRouter())
}
