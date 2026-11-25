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

    @Test("Add new route to path")
    func testPushNewRoteToPath() {
        let router = AppRouter()
        let route: Route = .homeScreen
        router.push(route)
        #expect(router.path.count > 0)
    }
    
    @Test("Remove last route from path")
    func testPopLastRoute() {
        let router = AppRouter()
        router.push(.homeScreen)
        router.push(.endMatchView)
        router.pop()
        #expect(router.path.count == 1)
    }
    
    @Test("Clean path routes")
    func testPopAll() {
        let router = AppRouter()
        router.push(.homeScreen)
        router.push(.endMatchView)
        
        router.popAll()
        
        #expect(router.path.count == 0)
    }
    
    @MainActor
    @Test("Show sheet")
    func testShowSheet() {
        let router = AppRouter()
        router.showSheet(.matchCreationView)
        #expect(router.actualSheet == .matchCreationView)
    }
    
    @Test("Close sheet")
    func testCloseSheet() {
        let router = AppRouter()
        router.showSheet(.matchCreationView)
        
        router.closeSheet()
        #expect(router.actualSheet == nil)
    }

}
