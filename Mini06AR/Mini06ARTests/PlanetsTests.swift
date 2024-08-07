//
//  Mini06ARTests.swift
//  Mini06ARTests
//
//  Created by Fabio Freitas on 22/07/24.
//

import XCTest
@testable import Mini06AR

final class PlanetsTests: XCTestCase {
    static private let numberOfPlanets = 8
    static private let numberOfModels = 10
    
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
        XCTAssertEqual(sut.count, Self.numberOfPlanets)
    }
    
    func testSolarSystemHasPlanets() {
        XCTAssertFalse(SolarSystem.solarSystemPlanets.isEmpty)
        XCTAssertEqual(SolarSystem.solarSystemPlanets.count, Self.numberOfPlanets)
    }
    
    func testPlanet3DModelsExists() {
        var usdzFiles: [String] = []
        if let resourcePath = Bundle.main.resourcePath, let items = try? FileManager.default.contentsOfDirectory(atPath: resourcePath)  {
            usdzFiles = items.filter { $0.hasSuffix(".usdz") }
        }
        XCTAssertFalse(usdzFiles.isEmpty)
        XCTAssertEqual(usdzFiles.count, Self.numberOfModels)
        XCTAssertEqual(SolarSystem.solarSystemPlanets.count, Self.numberOfPlanets)
    }
    
    func testPlanetModelHasDescription() {
        let descriptions = planets.compactMap({ $0.descriptions["Description 1"] })
        XCTAssertFalse(descriptions.isEmpty)
        XCTAssertEqual(descriptions.count, Self.numberOfModels)
    }
    
    func testPlanetModelsHaveCuriosity() {
        var curiosity = planets.compactMap({ $0.descriptions["Curiosity 2"] })
        XCTAssertFalse(curiosity.isEmpty)
        XCTAssertEqual(curiosity.count, Self.numberOfModels)
    }
}
