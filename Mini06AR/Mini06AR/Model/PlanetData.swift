//
//  PlanetData.swift
//  Mini06AR
//
//  Created by Guilherme Nunes Lobo on 23/07/24.
//

import Foundation

/**
 Um arquivo que contém os dados dos planetas do Sistema Solar.
 */

let planets = [
    
    // MARK: - Lua
    Planet(name: NSLocalizedString("Moon", comment: ""),
           radius: 1737.1,
           distanceFromSun: 149.6,
           descriptions: [
            "Descrição": NSLocalizedString("The only natural satellite of Earth, known for its influence on tides.", comment: ""),
            "Curiosidade 1": NSLocalizedString("The Moon is the fifth largest natural satellite in the Solar System.", comment: ""),
            "Curiosidade 2": NSLocalizedString("The visible face of the Moon is always the same due to its synchronized rotation with Earth.", comment: "")
           ],
           modelName: "moon.usdz"),
    // MARK: - Sol
    Planet(name: NSLocalizedString("Sun", comment: ""),
           radius: 696340.0,
           distanceFromSun: 0.0,
           descriptions: [
            "Descrição": NSLocalizedString("The star at the center of the Solar System, responsible for providing light and heat to Earth.", comment: ""),
            "Curiosidade 1": NSLocalizedString("The Sun is primarily composed of hydrogen and helium.", comment: ""),
            "Curiosidade 2": NSLocalizedString("The temperature at the surface of the Sun is about 15 million degrees Celsius.", comment: "")
           ],
           modelName: "sun.usdz"),
    
    // MARK: - Mercúrio
    Planet(name: NSLocalizedString("Mercury", comment: ""),
           radius: 2439.7,
           distanceFromSun: 57.9,
           descriptions: [
            "Descrição": NSLocalizedString("The smallest planet in the Solar System and the closest to the Sun.", comment: ""),
            "Curiosidade 1": NSLocalizedString("Mercury does not have a significant atmosphere to retain heat.", comment: ""),
            "Curiosidade 2": NSLocalizedString("The surface of Mercury is covered with craters.", comment: "")
           ],
           modelName: "mercury.usdz"),
    
    // MARK: - Vênus
    Planet(name: NSLocalizedString("Venus", comment: ""),
           radius: 6051.8,
           distanceFromSun: 108.2,
           descriptions: [
            "Descrição": NSLocalizedString("The second planet in the Solar System and the hottest.", comment: ""),
            "Curiosidade 1": NSLocalizedString("The atmosphere of Venus is primarily composed of carbon dioxide.", comment: ""),
            "Curiosidade 2": NSLocalizedString("Venus has an average surface temperature of 475 degrees Celsius.", comment: "")
           ],
           modelName: "venus.usdz"),
    
    // MARK: - Terra
    Planet(name: NSLocalizedString("Earth", comment: ""),
           radius: 6371.0,
           distanceFromSun: 149.6,
           descriptions: [
            "Descrição": NSLocalizedString("Our home, the third planet in the Solar System.", comment: ""),
            "Curiosidade 1": NSLocalizedString("Earth is the only known planet to harbor life.", comment: ""),
            "Curiosidade 2": NSLocalizedString("The surface of Earth is composed of 71% water.", comment: "")
           ],
           modelName: "earth.usdz"),
    
    // MARK: - Marte
    Planet(name: NSLocalizedString("Mars", comment: ""),
           radius: 3389.5,
           distanceFromSun: 227.9,
           descriptions: [
            "Descrição": NSLocalizedString("The Red Planet, the fourth in the Solar System.", comment: ""),
            "Curiosidade 1": NSLocalizedString("Mars has the highest mountain in the Solar System, Olympus Mons.", comment: ""),
            "Curiosidade 2": NSLocalizedString("The atmosphere of Mars is primarily composed of carbon dioxide.", comment: "")
           ],
           modelName: "mars.usdz"),
    
    // MARK: - Júpiter
    Planet(name: NSLocalizedString("Jupiter", comment: ""),
           radius: 69911,
           distanceFromSun: 778.5,
           descriptions: [
            "Descrição": NSLocalizedString("The largest planet in the Solar System, the fifth from the Sun.", comment: ""),
            "Curiosidade 1": NSLocalizedString("Jupiter has a giant red spot, which is an ongoing storm.", comment: ""),
            "Curiosidade 2": NSLocalizedString("Jupiter has more than 79 moons.", comment: "")
           ],
           modelName: "jupiter.usdz"),
    
    // MARK: - Saturno
    Planet(name: NSLocalizedString("Saturn", comment: ""),
           radius: 58232,
           distanceFromSun: 1433.5,
           descriptions: [
            "Descrição": NSLocalizedString("Known for its impressive rings, it is the sixth planet in the Solar System.", comment: ""),
            "Curiosidade 1": NSLocalizedString("Saturn's rings are primarily made of ice and rock.", comment: ""),
            "Curiosidade 2": NSLocalizedString("Saturn has 145 known moons.", comment: "")
           ],
           modelName: "saturn.usdz"),
    
    // MARK: - Urano
    Planet(name: NSLocalizedString("Uranus", comment: ""),
           radius: 25362,
           distanceFromSun: 2872.5,
           descriptions: [
            "Descrição": NSLocalizedString("The seventh planet in the Solar System, known for its bluish color.", comment: ""),
            "Curiosidade 1": NSLocalizedString("Uranus rotates on its side, with its axis of rotation almost parallel to the plane of its orbit.", comment: ""),
            "Curiosidade 2": NSLocalizedString("Uranus has 27 known moons.", comment: "")
           ],
           modelName: "uranus.usdz"),
    
    // MARK: - Netuno
    Planet(name: NSLocalizedString("Neptune", comment: ""),
           radius: 24622,
           distanceFromSun: 4495.1,
           descriptions: [
            "Descrição": NSLocalizedString("The eighth planet in the Solar System, known for its strong winds.", comment: ""),
            "Curiosidade 1": NSLocalizedString("Neptune has the fastest winds in the Solar System, reaching up to 2,100 km/h.", comment: ""),
            "Curiosidade 2": NSLocalizedString("Neptune has 14 known moons.", comment: "")
           ],
           modelName: "neptune.usdz")
]
