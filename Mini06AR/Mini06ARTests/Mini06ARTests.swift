//
//  Mini06ARTests.swift
//  Mini06ARTests
//
//  Created by Fabio Freitas on 22/07/24.
//

import XCTest
@testable import Mini06AR

final class Mini06ARTests: XCTestCase {
    func testAppHasPlanets() {
        XCTAssertFalse(planets.isEmpty)
    }
    
    func testAppHasMoon() {
        XCTAssertFalse(planets.filter({ $0.name.localizedCaseInsensitiveContains("moon") }).isEmpty)
    }
    
    func testAppHasSun() {
        XCTAssertFalse(planets.filter({ $0.name.localizedCaseInsensitiveContains("sun") }).isEmpty)
    }
    
    func testAppHasAllThePlanets() {
        let sut = planets.filter({ !($0.name.localizedCaseInsensitiveContains("moon") || $0.name.localizedCaseInsensitiveContains("sun")) })
        XCTAssertFalse(sut.isEmpty)
        XCTAssertEqual(sut.count, 8)
    }
}
