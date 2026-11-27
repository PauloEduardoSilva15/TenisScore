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

    @Query private var matches: [Match]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            AppBackgroundImg(Image(.appBackgroundImg))
        }
        .navigationTitle("Jogos anteriores")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    router.push(.newMatchView)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .toolbarTitleDisplayMode(.inlineLarge)
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
    .environment(AppRouter())
}
