//
//  AppRouter.swift
//  TenisScore
//
//  Created by Paulo Eduardo Barbosa da Silva on 23/11/26.
//

import Observation
import SwiftUI

/// Handles the application's navigation flow.
///
/// Manages the navigation stack through a `NavigationPath`,
/// providing methods to push, pop, and clear routes.
///
/// The router also manages modal presentation through
/// `actualSheet`, allowing sheets to be presented and dismissed.
@Observable
final class AppRouter {
    /// Navigation stack used by `NavigationStack`.
//    var path = NavigationPath()
    var path: [Route] = []
    
    /// Currently presented sheet, if any.
    var currentSheet: Route?
    
    /// Pushes a new route onto the navigation stack.
    ///
    /// - Parameter route: The destination route to be presented.
    func push(_ route: Route) {
        guard path.last != route else { return }
        
        path.append(route)
    }
    
    /// Removes the most recently pushed route from the navigation stack.
    func pop() {
        guard !path.isEmpty else { return }
        
        path.removeLast()
    }
    
    /// Removes all routes from the navigation stack,
    /// returning the user to the root screen.
    func popAll() {
        path.removeAll()
    }
    
    /// Presents a sheet for the specified route.
    ///
    /// - Parameter route: The route associated with the sheet to present.
    func showSheet(_ route: Route) {
        currentSheet = route
    }
    
    /// Dismisses the currently presented sheet.
    func closeSheet() {
        currentSheet = nil
    }
    
    /// Marks the onboarding flow as completed.
    ///
    /// Stores a flag in `UserDefaults` so the onboarding
    /// screen is not shown again on future launches.
    ///
    /// To reset this value during development, remove the app
    /// from the simulator or device and install it again.
    func endOnboarding() {
        UserDefaults.standard.set(true, forKey: "onboardingDone")
    }
}
