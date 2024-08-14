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

    // MARK: - Moon
    Planet(name: NSLocalizedString("Moon", comment: ""),
           morseCode: "-- --- --- -.",
           radius: 1737.1,
           distanceFromSun: 149.6,
           descriptions: [
            "Description 1": NSLocalizedString("The Giant Impact Theory is the most common explanation for the moon's formation. An object the size of Mars collided with the young Earth about 4.5 billion years ago, according to this theory. The debris from this collision formed the Moon.", comment: ""),
            "Description 2": NSLocalizedString("The Moon has a significant influence on Earths tides. High and low tides are created by the moon's gravity pulling the oceans. The Moon would make tides weaker and the Earth's climate could be very different, impacting marine life and coastal ecosystems.", comment: ""),
            "Description 3": NSLocalizedString("The goddess Luna was personified in Roman mythology. The lunar cycles and the night were overseen by her. Luna was often depicted driving a silver chariot across the night sky, as Luna was often depicted driving a silver chariot.", comment: ""),
            "Curiosity 1": NSLocalizedString("The Moon is the fifth largest natural satellite in the Solar System.", comment: ""),
            "Curiosity 2": NSLocalizedString("Due to its synchronous rotation with Earth, the visible face of the Moon is always the same.", comment: "")
           ],
           modelName: "moon.usdz"),
    
    // MARK: - Sun
    Planet(name: NSLocalizedString("Sun", comment: ""),
           morseCode: "... ..- -.",
           radius: 696340.0,
           distanceFromSun: 0.0,
           descriptions: [
            "Description 1": NSLocalizedString("The Sun's composition and energy are dominated by hydrogen and helium, with a few heavier elements. A huge amount of energy is released when nuclear fusion transforms hydrogen into helium in the Sun's core. Life on Earth is sustained by this energy as light and heat.", comment: ""),
            "Description 2": NSLocalizedString("Solar cycles are activity cycles of approximately 11 years that the Sun goes through. The Sun's activity increases during solar maximum, leading to more sunspots, solar flares, and coronal mass ejections.", comment: ""),
            "Description 3": NSLocalizedString("Roman mythology personified the Sun by the god Sol, also known as Sol Invictus (Unconquered Sun) The light, heat, and vitality that sustain life on Earth were represented by him. It was common to see Sol driving a golden chariot across the sky during the day.", comment: ""),
            "Curiosity 1": NSLocalizedString("The Sun is composed primarily of hydrogen and helium.", comment: ""),
            "Curiosity 2": NSLocalizedString("The surface of the Sun has a temperature of 15 million degrees Celsius, according to NASA.", comment: "")
           ],
           modelName: "sun.usdz"),
    
    // MARK: - Mercury
    Planet(name: NSLocalizedString("Mercury", comment: ""),
           morseCode: "-- . .-. -.-. ..- .-. -.--",
           radius: 2439.7,
           distanceFromSun: 57.9,
           descriptions: [
            "Description 1": NSLocalizedString("The planet has the most extreme surface temperatures, ranging from -180°C at night to 430°C during the day. Mercury isn't the hottest planet, a title that belongs to Venus.", comment: ""),
            "Description 2": NSLocalizedString("The second densest planet in the solar system has a large iron core that occupies about 75% of its radius, in addition to its extreme temperatures.", comment: ""),
            "Description 3": NSLocalizedString("The Roman god Mercury was associated with commerce, travel, communication, and robbery. His speed and ability are what make him a messenger of the gods. Mercury, the fastest planet to orbit the Sun, reflects the god's agility.", comment: ""),
            "Curiosity 1": NSLocalizedString("Mercury does not have a significant atmosphere that can retain heat.", comment: ""),
            "Curiosity 2": NSLocalizedString("The planet's surface is dotted with craters.", comment: "")
           ],
           modelName: "mercury.usdz"),
    
    // MARK: - Venus
    Planet(name: NSLocalizedString("Venus", comment: ""),
           morseCode: "...- . -. ..- ...",
           radius: 6051.8,
           distanceFromSun: 108.2,
           descriptions: [
            "Description 1": NSLocalizedString("The planet's extreme greenhouse effect makes it the hottest in the solar system, with average temperatures hovering around 465 C. Its dense, acidic atmosphere is mainly composed of carbon dioxide and clouds of sulfuric acid.", comment: ""),
            "Description 2": NSLocalizedString("The retrograde direction of Venus means that it spins opposite to most planets. This causes the Sun to rise in the west and set in the east on Venus, causing the Sun to rise in the west and set in the east. A day on Venus (one full rotation) lasts longer than a year on Venus (one full orbit around the Sun)", comment: ""),
            "Description 3": NSLocalizedString("In Roman mythology, Venus was represented as the goddess of love, beauty, and fertility. The planet Venus, being the brightest in the night sky, symbolizes the dazzling beauty of the goddess of love. The planet Venus symbolizes the dazzling beauty of the goddess of love.", comment: ""),
            "Curiosity 1": NSLocalizedString("Carbon dioxide is the main component of the Venusian atmosphere.", comment: ""),
            "Curiosity 2": NSLocalizedString("Venus' surface temperature is 475 degrees Celsius, according to NASA.", comment: "")
           ],
           modelName: "venus.usdz"),
    
    // MARK: - Earth
    Planet(name: NSLocalizedString("Earth", comment: ""),
           morseCode: ". .- .-. - ....",
           radius: 6371.0,
           distanceFromSun: 149.6,
           descriptions: [
            "Description 1": NSLocalizedString("The only known planet to have life on it. The planet's oxygen-rich atmosphere and plentiful water supply are essential for life as we know it.", comment: ""),
            "Description 2": NSLocalizedString("The size of Earth's moon makes it the largest natural satellite in the solar system. The presence of the Moon has an important impact on climate and seasons.", comment: ""),
            "Description 3": NSLocalizedString("The goddess of earth and fertility was represented in Roman culture by Earth. The goddess who represents life and fertility is honored in the name of our planet, reflecting Earth's importance as the home of all known life.", comment: ""),
            "Curiosity 1": NSLocalizedString("Earth is the only known planet with water in all three states: solid, liquid, and gas.", comment: ""),
            "Curiosity 2": NSLocalizedString("71% of the surface of the Earth is water.", comment: "")
           ],
           modelName: "earth.usdz"),
    
    // MARK: - Mars
    Planet(name: NSLocalizedString("Mars", comment: ""),
           morseCode: "-- .- .-. ...",
           radius: 3389.5,
           distanceFromSun: 227.9,
           descriptions: [
            "Description 1": NSLocalizedString("The Red Planet is known as the Red Planet due to iron oxide on its surface. The largest mountain in the solar system is Olympus Mons, and one of the largest canyons is Valles Marineris.", comment: ""),
            "Description 2": NSLocalizedString("There are two small moons on Mars that are believed to be captured asteroids. Additionally, Mars has evidence of liquid water on its surface in the past, and there may still be liquid water underground. Mars has evidence of liquid water on its surface in the past, and there may still be liquid water underground.", comment: ""),
            "Description 3": NSLocalizedString("The god of war was Mars to the Romans. The red soil of Mars symbolizes blood and aggression, symbolizing the god's warlike character.", comment: ""),
            "Curiosity 1": NSLocalizedString("Olympus Mons is the highest mountain in the solar system.", comment: ""),
            "Curiosity 2": NSLocalizedString("Carbon dioxide dominates the composition of Mars' atmosphere.", comment: "")
           ],
           modelName: "mars.usdz"),
    
    // MARK: - Jupiter
    Planet(name: NSLocalizedString("Jupiter", comment: ""),
           morseCode: ".--- ..- .--. .. - . .-.",
           radius: 69911,
           distanceFromSun: 778.5,
           descriptions: [
            "Description 1": NSLocalizedString("A mass more than 300 times that of Earth makes it the largest planet in the solar system. A storm larger than Earth that has been active for at least 400 years is known as the Great Red Spot on Jupiter. There are 95 known moons, including Europa, which may have a potentially habitable subsurface ocean.", comment: ""),
            "Description 2": NSLocalizedString("The Great Red Spot isn't the only storm in Jupiter's turbulent atmosphere. Jupiter's magnetic field is 14 times stronger than Earth's, and it has a huge magnetosphere that encompasses many of its moons.", comment: ""),
            "Description 3": NSLocalizedString("Jupiter was a god of thunder and sky in Roman mythology. Jupiter, the largest planet in the solar system, reflects the grandeur and supremacy of the gods.", comment: ""),
            "Curiosity 1": NSLocalizedString("There is a giant red spot on Jupiter that is an ongoing storm.", comment: ""),
            "Curiosity 2": NSLocalizedString("Jupiter has 95 moons.", comment: "")
           ],
           modelName: "jupiter.usdz"),
    
    // MARK: - Saturn
    Planet(name: NSLocalizedString("Saturn", comment: ""),
           morseCode: "... .- - ..- .-. -. ",
           radius: 58232,
           distanceFromSun: 1433.5,
           descriptions: [
            "Description 1": NSLocalizedString("It is famous for its extensive ring system of ice and rock particles. The largest moon of Saturn, Titan, is larger than Mercury and has a thick atmosphere and surface lakes of liquid methane.", comment: ""),
            "Description 2": NSLocalizedString("There are 83 known moons on Saturn. It could float in a hypothetical ocean large enough to hold it because of its composition of hydrogen and helium.", comment: ""),
            "Description 3": NSLocalizedString("The Roman god Saturn was associated with agriculture and harvest. The Greek god Cronus, the god of time, was often associated with him.", comment: ""),
            "Curiosity 1": NSLocalizedString("Saturn is composed of hydrogen and helium.", comment: ""),
            "Curiosity 2": NSLocalizedString("Saturn is the second-largest planet in the Solar System.", comment: "")
           ],
           modelName: "saturn.usdz"),

    // MARK: - Uranus
    Planet(name: NSLocalizedString("Uranus", comment: ""),
           morseCode: "..- .-. .- -. ..- ...",
           radius: 25362,
           distanceFromSun: 2872.5,
           descriptions: [
            "Description 1": NSLocalizedString("There's a gas giant that rotates on its side with a 98-degree axial tilt. A blueish color is given to its atmosphere by methane. Uranus has 27 known moons, the most famous of which are Titania and Oberon.", comment: ""),
            "Description 2": NSLocalizedString("A magnetic field tilted almost 60 degrees from its axis of rotation is what makes Uranus so faint. The extreme axial tilt causes extreme seasonal variations, with each pole experiencing 42 years of continuous sunlight or darkness. The extreme axial tilt causes extreme seasonal variations, with each pole experiencing 42 years of continuous sunlight or darkness.", comment: ""),
            "Description 3": NSLocalizedString("Uranus was a primordial being who symbolized the heavens in Roman mythology. Uranus, being one of the most distant and mysterious planets, represents the infinite sky and the mysteries of the universe.", comment: ""),
            "Curiosity 1": NSLocalizedString("The planet Uranus is tilted 98 degrees on its axis.", comment: ""),
            "Curiosity 2": NSLocalizedString("The third-largest planet in our solar system is Uranus.", comment: "")
           ],
           modelName: "uranus.usdz"),

    // MARK: - Neptune
    Planet(name: NSLocalizedString("Neptune", comment: ""),
           morseCode: "-. . .--. - ..- -. .",
           radius: 24622,
           distanceFromSun: 4495.1,
           descriptions: [
            "Description 1": NSLocalizedString("The farthest planet from the sun is known for its intense blue hue and strong winds, which can reach speeds of over 2000 km/h. The largest moon of Neptune is Triton, which orbits the planet in the opposite direction of its rotation.", comment: ""),
            "Description 2": NSLocalizedString("The Great Dark Spot is similar to Jupiter's Great Red Spot, but it seems to appear and disappear over time. The ring system of Neptune is much fainter than the one of Saturn.", comment: ""),
            "Description 3": NSLocalizedString("The god of the sea, Neptune, was responsible for governing the waters and storms in Roman mythology. The deep blue hue of Neptune represents the power and mystery of the ocean.", comment: ""),
            "Curiosity 1": NSLocalizedString("Neptune has 14 moons.", comment: ""),
            "Curiosity 2": NSLocalizedString("The strongest winds in the Solar System can reach speeds of over 2,000 km/h for Neptune.", comment: "")
           ],
           modelName: "neptune.usdz"),
]
