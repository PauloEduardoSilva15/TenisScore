//
//  NewMatchView.swift
//  TenisScore
//
//  Created by Igor Carrasco on 26/11/26.
//

import SwiftUI

struct NewMatchView: View {
    @Environment(AppRouter.self) private var router

    @State private var sets: MatchSetQuantity = .five
    @State private var playerQuantity: MatchPlayerQuantity = .singles
    @State private var names = Array(repeating: "", count: 4)
    @State private var showInvalidInputsAlert = false

    @State private var isToggle1 = false
    @State private var isToggle2 = false

    private let verticalFieldPadding: CGFloat = 12
    private let horizontalFieldPadding: CGFloat = 15

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                FormSectionTitle("Tênis")

                LiquidGlassCard {
                    HStack {
                        Text("Número de sets")
                            .foregroundStyle(
                                .text
                            )
                        Spacer()
                        Picker("Sets", selection: $sets) {
                            ForEach(MatchSetQuantity.allCases) {
                                Text($0.name)
                                    .foregroundStyle(
                                        .text
                                    )
                            }
                        }
                    }
                    .padding(.vertical, verticalFieldPadding)
                    .padding(.horizontal, horizontalFieldPadding)
                }
                .padding(.bottom)

                LiquidGlassCard {
                    HStack {
                        Text("Número de jogadores")
                            .foregroundStyle(
                                .text
                            )
                        Spacer()
                        Picker("Sets", selection: $playerQuantity) {
                            ForEach(MatchPlayerQuantity.allCases) {
                                Text($0.name)
                                    .foregroundStyle(
                                        .text
                                    )
                            }
                        }
                    }
                    .padding(.vertical, verticalFieldPadding)
                    .padding(.horizontal, horizontalFieldPadding)
                }
            }
            .padding()

            VStack(alignment: .leading) {
                FormSectionTitle("Jogadores")

                LiquidGlassCard {
                    VStack {
                        PlayersSection(
                            playerQuantity: playerQuantity,
                            names: $names
                        )
                    }
                }
            }
            .padding(.horizontal)

            VStack(alignment: .leading) {
                LiquidGlassCard {
                    Toggle(isOn: $isToggle1) {
                        Text("Sortear membros dos times")
                            .foregroundStyle(
                                .text
                            )
                    }
                    .padding(.vertical, verticalFieldPadding)
                    .padding(.horizontal, horizontalFieldPadding)
                }
                .padding(.bottom, 7)

                Text(
                    "Caso não selecione esse toggle, as equipes serão distribuídas em ordem de inserção"
                )
                .font(.caption2)
                .foregroundStyle(.titleBtnText)
            }
            .padding()

            VStack(alignment: .leading) {
                LiquidGlassCard {
                    Toggle(isOn: $isToggle2) {
                        Text("Saque aleatório")
                            .foregroundStyle(
                                .text
                            )
                    }
                    .padding(.vertical, verticalFieldPadding)
                    .padding(.horizontal, horizontalFieldPadding)
                }
            }
            .padding(.horizontal)

            ConfirmButton("Iniciar partida") {
                let playerNames = names.prefix(playerQuantity.totalPlayers).map {
                    $0.trimmingCharacters(in: .whitespacesAndNewlines)
                }
                guard playerNames.allSatisfy({ !$0.isEmpty }) else {
                    showInvalidInputsAlert = true
                    return
                }

                do {
                    let match = try Match(
                        players: playerNames.map { Player(name: $0) },
                        playerQuantity: playerQuantity,
                        setQuantity: sets
                    )
                    router.push(.resumeMatchView(match: match))
                } catch {
                    fatalError("Falha ao criar novo modelo")
                }
            }
            .padding()
        }
        .scrollDismissesKeyboard(.immediately)
        .background {
            AppBackgroundImg(Image(.appBackgroundImg))
        }
        .alert("Entradas inválidas", isPresented: $showInvalidInputsAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Preencha o nome de todos os jogadores para iniciar a partida.")
        }
        .navigationTitle("Nova partida")
        .toolbarTitleDisplayMode(.inlineLarge)
    }
}

struct FormSectionTitle: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(.subheadline)
            .foregroundStyle(.white)
    }
}

/// A section with one editable name field per player.
struct PlayersSection: View {
    /// Selected match mode.
    let playerQuantity: MatchPlayerQuantity
    /// Typed names. Must always hold 4 slots.
    @Binding var names: [String]

    var body: some View {
        VStack {
            ForEach(0..<playerQuantity.totalPlayers, id: \.self) { index in
                TextField("Jogador \(index + 1)", text: $names[index])

                if index < playerQuantity.totalPlayers - 1 {
                    Divider()
                }
            }
        }
        .padding()
    }
}

extension MatchPlayerQuantity {
    /// Total number of players in the match (both sides).
    var totalPlayers: Int { rawValue * 2 }

    /// Returns the final player names, replacing blank ones with a default.
    /// - Parameter typed: Names typed by the user, in field order.
    /// - Returns: Exactly ``totalPlayers`` names.
    func resolvedNames(from typed: [String]) -> [String] {
        (0..<totalPlayers).map { index in
            let name =
                index < typed.count
                ? typed[index].trimmingCharacters(in: .whitespaces)
                : ""
            return name.isEmpty ? "Jogador \(index + 1)" : name
        }
    }
}

#Preview {
    NavigationView {
        NewMatchView()
    }
    .environment(AppRouter())
}
