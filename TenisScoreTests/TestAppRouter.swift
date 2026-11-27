//
//  TestAppRouter.swift
//  TenisScoreTests
//
//  Created by Igor Carrasco on 24/11/26.
//

import Testing
import SwiftUI
@testable import TenisScore

struct TestAppRouter {
    
    @Test("Router starts with empty navigation state")
    func testRouterInitialState() {
        let router = AppRouter()

        #expect(router.path.count == 0)
        #expect(router.currentSheet == nil)
    }

    @Test("Add new route to path")
    func testPushNewRouteToPath() {
        let router = AppRouter()
        #expect(router.path.count == 0)
        let route: Route = .homeScreen
        router.push(route)
        #expect(router.path.count == 1)
    }
    
    @Test("Remove last route from path")
    func testPopLastRoute() {
        let router = AppRouter()
        router.push(.endMatchView)
        router.push(.homeScreen)
        router.push(.endMatchView)
        router.pop()
        #expect(router.path.last == .homeScreen)
    }
    
    @Test("Clean path routes")
    func testPopAll() {
        let router = AppRouter()
        router.push(.homeScreen)
        router.push(.endMatchView)
        router.push(.newMatchView)
        router.push(.onMatchView)
        
        router.popAll()
        
        #expect(router.path.count == 0)
    }
    
    @MainActor
    @Test("Show sheet")
    func testShowSheet() {
        let router = AppRouter()
        router.showSheet(.newMatchView)
        #expect(router.currentSheet == .newMatchView)
    }
    
    @Test("Close sheet")
    func testCloseSheet() {
        let router = AppRouter()
        router.showSheet(.newMatchView)
        
        router.closeSheet()
        #expect(router.currentSheet == nil)
    }

}
