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
    Planet(name: "Moon",
           radius: 1737.1,
           distanceFromSun: 149.6,
           descriptions: [
            "Descrição": "The only natural satellite of Earth, known for its influence on tides.",
            "Curiosidade 1": "The Moon is the fifth largest natural satellite in the Solar System.",
            "Curiosidade 2": "The visible face of the Moon is always the same due to its synchronized rotation with Earth."
           ],
           modelName: "moon.usdz"),
    // MARK: - Sol
    Planet(name: "Sun",
           radius: 696340.0,
           distanceFromSun: 0.0,
           descriptions: [
            "Descrição": "The star at the center of the Solar System, responsible for providing light and heat to Earth.",
            "Curiosidade 1": "The Sun is primarily composed of hydrogen and helium.",
            "Curiosidade 2": "The temperature at the surface of the Sun is about 15 million degrees Celsius."
           ],
           modelName: "sun.usdz"),
    
    // MARK: - Mercúrio
    Planet(name: "Mercury",
           radius: 2439.7,
           distanceFromSun: 57.9,
           descriptions: [
            "Descrição": "The smallest planet in the Solar System and the closest to the Sun.",
            "Curiosidade 1": "Mercury does not have a significant atmosphere to retain heat.",
            "Curiosidade 2": "The surface of Mercury is covered with craters."
           ],
           modelName: "mercury.usdz"),
    
    // MARK: - Vênus
    Planet(name: "Venus",
           radius: 6051.8,
           distanceFromSun: 108.2,
           descriptions: [
            "Descrição": "The second planet in the Solar System and the hottest.",
            "Curiosidade 1": "The atmosphere of Venus is primarily composed of carbon dioxide.",
            "Curiosidade 2": "Venus has an average surface temperature of 475 degrees Celsius."
           ],
           modelName: "venus.usdz"),
    
    // MARK: - Terra
    Planet(name: "Earth",
           radius: 6371.0,
           distanceFromSun: 149.6,
           descriptions: [
            "Descrição": "Our home, the third planet in the Solar System.",
            "Curiosidade 1": "Earth is the only known planet to harbor life.",
            "Curiosidade 2": "The surface of Earth is composed of 71% water."
           ],
           modelName: "earth.usdz"),
    
    // MARK: - Marte
    Planet(name: "Mars",
           radius: 3389.5,
           distanceFromSun: 227.9,
           descriptions: [
            "Descrição": "The Red Planet, the fourth in the Solar System.",
            "Curiosidade 1": "Mars has the highest mountain in the Solar System, Olympus Mons.",
            "Curiosidade 2": "The atmosphere of Mars is primarily composed of carbon dioxide."
           ],
           modelName: "mars.usdz"),
    
    // MARK: - Júpiter
    Planet(name: "Jupiter",
           radius: 69911,
           distanceFromSun: 778.5,
           descriptions: [
            "Descrição": "The largest planet in the Solar System, the fifth from the Sun.",
            "Curiosidade 1": "Jupiter has a giant red spot, which is an ongoing storm.",
            "Curiosidade 2": "Jupiter has more than 79 moons."
           ],
           modelName: "jupiter.usdz"),
    
    // MARK: - Saturno
    Planet(name: "Saturn",
           radius: 58232,
           distanceFromSun: 1433.5,
           descriptions: [
            "Descrição": "Known for its impressive rings, it is the sixth planet in the Solar System.",
            "Curiosidade 1": "Saturn's rings are primarily made of ice and rock.",
            "Curiosidade 2": "Saturn has 145 known moons."
           ],
           modelName: "saturn.usdz"),
    
    // MARK: - Urano
    Planet(name: "Uranus",
           radius: 25362,
           distanceFromSun: 2872.5,
           descriptions: [
            "Descrição": "The seventh planet in the Solar System, known for its bluish color.",
            "Curiosidade 1": "Uranus rotates on its side, with its axis of rotation almost parallel to the plane of its orbit.",
            "Curiosidade 2": "Uranus has 27 known moons."
           ],
           modelName: "uranus.usdz"),
    
    // MARK: - Netuno
    Planet(name: "Neptune",
           radius: 24622,
           distanceFromSun: 4495.1,
           descriptions: [
            "Descrição": "The eighth planet in the Solar System, known for its strong winds.",
            "Curiosidade 1": "Neptune has the fastest winds in the Solar System, reaching up to 2,100 km/h.",
            "Curiosidade 2": "Neptune has 14 known moons."
           ],
           modelName: "neptune.usdz")
]
