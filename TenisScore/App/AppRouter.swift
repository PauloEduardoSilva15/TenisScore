//
//  AppRouter.swift
//  TenisScore
//
//  Created by Paulo Eduardo Barbosa da Silva on 23/11/26.
//

import Observation
import SwiftUI

/// Classe responsável pelos métodos de navegação.
///
/// Inicia o `NavigationPath()` e implementa métodos de adicionar uma nova rota ao path, remover a última rota adicionada ao path e limpar o path removendo todas as rotas na lista.
/// 
/// A classe também tem a variável `actualSheet`, utilizada para mostrar uma sheet com os métodos `showSheet(_:)` e `closeSheet()`.
@Observable
final class AppRouter {
    /// Cria e inicia o NavigationPath
    var path = NavigationPath()
    
    /// Guarda a sheet atual, caso houver
    var actualSheet: Route?
    
    /// Adiciona uma rota ao path
    /// Utiliza o método `.append` aplicado ao `path` para adicionar a rota
    /// - Parameters:
    ///     - route: Uma das rotas do enum `Route`.
    func push(_ route: Route) {
        path.append(route)
    }
    
    /// Remove a última rota que foi adiciona ao path
    /// - Utiliza o método `.removeLast()` aplicado ao `path` para remover a última rota adicionada
    func pop() {
        path.removeLast()
    }
    
    /// Limpa o path de navegação, removendo todas as rotas.
    /// - Utiliza o método `.removeLast()`, passando como parâmetro a quantidade de itens em `path`, para limpar toda a lista de rotas.
    func popAll() {
        path.removeLast(path.count)
    }
    
    /// Atribui uma rota a variável `actualSheet`
    /// - Parameters:
    ///     - route: Uma das rotas do enum `Route`.
    func showSheet(_ route: Route) {
        actualSheet = route
    }
    
    /// Fecha a sheet atual,
    /// - Atribui o valor `nil` a variável `actualSheet`
    func closeSheet() {
        actualSheet = nil
    }
    
    /// Função que verifica o `UserDefaults` para saber se o dispositivo do usuário já fez onBoarding alguma vez
    /// - Para resetar o `UserDefaults` é necessário desisntalar e reinstalar o aplicativo no simulador ou dispositivo
    func endOnboarding() {
        UserDefaults.standard.set(true, forKey: "onboardingDone")
    }
}
