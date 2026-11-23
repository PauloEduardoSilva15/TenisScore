//
//  AppRouter.swift
//  TenisScore
//
//  Created by Paulo Eduardo Barbosa da Silva on 23/11/26.
//

import Observation
import SwiftUI

@Observable
final class AppRouter {
    var path = NavigationPath()
    
    var actualSheet: Route? //Caso a gente use sheets
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popAll() {
        path.removeLast(path.count)
    }
    
    func showSheet(_ route: Route) {
        actualSheet = route
    }
    
    func closeSheet() {
        actualSheet = nil
    }
    
    // Para não abrir mais o onboarding após primeiro uso
    func endOnboarding() {
        UserDefaults.standard.set(true, forKey: "onboardingDone")
    }
}
