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
            "Description 1": NSLocalizedString("The most accepted theory about the formation of the Moon is the Giant Impact Theory. According to this theory, the Moon formed about 4.5 billion years ago when an object the size of Mars, called Theia, collided with the young Earth. The debris resulting from this collision coalesced to form the Moon.", comment: ""),
            "Description 2": NSLocalizedString("The Moon exerts a significant influence on Earth's tides. The Moon's gravity pulls the oceans, creating high and low tides. Without the Moon, tides would be much weaker, and Earth's climate could be very different, impacting marine life and coastal ecosystems.", comment: ""),
            "Description 3": NSLocalizedString("In Roman mythology, the Moon was personified by the goddess Luna. She was the goddess of the moon and presided over the lunar cycles and the night. Luna was often depicted driving a silver chariot across the night sky.", comment: ""),
            "Curiosity 1": NSLocalizedString("The Moon is the fifth largest natural satellite in the Solar System.", comment: ""),
            "Curiosity 2": NSLocalizedString("The visible face of the Moon is always the same due to its synchronized rotation with Earth.", comment: "")
           ],
           modelName: "moon.usdz"),
    
    // MARK: - Sun
    Planet(name: NSLocalizedString("Sun", comment: ""),
           morseCode: "... ..- -.",
           radius: 696340.0,
           distanceFromSun: 0.0,
           descriptions: [
            "Description 1": NSLocalizedString("Composition and Energy: The Sun is a star composed mainly of hydrogen (about 74%) and helium (about 24%), with traces of heavier elements. In the Sun's core, nuclear fusion converts hydrogen into helium, releasing an enormous amount of energy. This energy is radiated into space as light and heat, sustaining life on Earth.", comment: ""),
            "Description 2": NSLocalizedString("The Sun goes through activity cycles of approximately 11 years, known as solar cycles. During solar maximum, the Sun's activity increases, resulting in more sunspots, solar flares, and coronal mass ejections.", comment: ""),
            "Description 3": NSLocalizedString("In Roman mythology, the Sun was personified by the god Sol, also known as Sol Invictus (Unconquered Sun). He was the god of the sun, representing the light, heat, and vitality that sustain life on Earth. Sol was often depicted driving a golden chariot across the sky during the day.", comment: ""),
            "Curiosity 1": NSLocalizedString("The Sun is primarily composed of hydrogen and helium.", comment: ""),
            "Curiosity 2": NSLocalizedString("The temperature at the surface of the Sun is about 15 million degrees Celsius.", comment: "")
           ],
           modelName: "sun.usdz"),
    
    // MARK: - Mercury
    Planet(name: NSLocalizedString("Mercury", comment: ""),
           morseCode: "-- . .-. -.-. ..- .-. -.--",
           radius: 2439.7,
           distanceFromSun: 57.9,
           descriptions: [
            "Description 1": NSLocalizedString("It is the closest planet to the Sun and has the most extreme surface temperatures, ranging from -180°C at night to 430°C during the day. Despite this, Mercury is not the hottest planet, a title that belongs to Venus.", comment: ""),
            "Description 2": NSLocalizedString("In addition to its extreme temperatures, Mercury has a highly elliptical orbit and is the second densest planet in the solar system, with a large iron core that occupies about 75% of its radius.", comment: ""),
            "Description 3": NSLocalizedString("In Roman mythology, Mercury was the god of commerce, travelers, communication, and thieves. He is known for his speed and ability as the messenger of the gods. The planet Mercury, the fastest to orbit the Sun, reflects the agility of the god.", comment: ""),
            "Curiosity 1": NSLocalizedString("Mercury does not have a significant atmosphere to retain heat.", comment: ""),
            "Curiosity 2": NSLocalizedString("The surface of Mercury is covered with craters.", comment: "")
           ],
           modelName: "mercury.usdz"),
    
    // MARK: - Venus
    Planet(name: NSLocalizedString("Venus", comment: ""),
           morseCode: "...- . -. ..- ...",
           radius: 6051.8,
           distanceFromSun: 108.2,
           descriptions: [
            "Description 1": NSLocalizedString("This is the hottest planet in the solar system, with average temperatures around 465°C due to its extreme greenhouse effect. Its dense and acidic atmosphere is mainly composed of carbon dioxide and clouds of sulfuric acid.", comment: ""),
            "Description 2": NSLocalizedString("Venus rotates in a retrograde direction, meaning it spins opposite to most planets. This causes the Sun to rise in the west and set in the east on Venus. A day on Venus (one full rotation) lasts longer than a Venusian year (one full orbit around the Sun).", comment: ""),
            "Description 3": NSLocalizedString("In Roman mythology, Venus represented the goddess of love, beauty, and fertility. The planet Venus, being the brightest in the night sky, symbolizes the dazzling beauty of the goddess of love.", comment: ""),
            "Curiosity 1": NSLocalizedString("The atmosphere of Venus is primarily composed of carbon dioxide.", comment: ""),
            "Curiosity 2": NSLocalizedString("Venus has an average surface temperature of 475 degrees Celsius.", comment: "")
           ],
           modelName: "venus.usdz"),
    
    // MARK: - Earth
    Planet(name: NSLocalizedString("Earth", comment: ""),
           morseCode: ". .- .-. - ....",
           radius: 6371.0,
           distanceFromSun: 149.6,
           descriptions: [
            "Description 1": NSLocalizedString("The only known planet to harbor life. Earth has an oxygen-rich atmosphere and abundant liquid water, essential factors for life as we know it.", comment: ""),
            "Description 2": NSLocalizedString("Earth has a single moon, which is the largest natural satellite in relation to the size of its planet. The presence of the Moon stabilizes Earth's axial tilt, which has an important impact on climate and seasons.", comment: ""),
            "Description 3": NSLocalizedString("In Roman culture, Earth (or Tellus) symbolized the goddess of earth and fertility. The name of our planet honors the goddess who represents life and fertility, reflecting Earth's importance as the home of all known life.", comment: ""),
            "Curiosity 2": NSLocalizedString("The surface of Earth is composed of 71% water.", comment: "")
           ],
           modelName: "earth.usdz"),
    
    // MARK: - Mars
    Planet(name: NSLocalizedString("Mars", comment: ""),
           morseCode: "-- .- .-. ...",
           radius: 3389.5,
           distanceFromSun: 227.9,
           descriptions: [
            "Description 1": NSLocalizedString("Known as the Red Planet due to iron oxide on its surface. Mars has the largest volcanic mountain in the solar system, Olympus Mons, and one of the largest canyons, Valles Marineris.", comment: ""),
            "Description 2": NSLocalizedString("Mars has two small, irregular moons, Phobos and Deimos, believed to be captured asteroids. Additionally, Mars has evidence of liquid water on its surface in the past, and there may still be liquid water underground.", comment: ""),
            "Description 3": NSLocalizedString("To the Romans, Mars was the god of war. The red soil of the planet Mars resembles blood and the aggression of war, symbolizing the warlike character of the god.", comment: ""),
            "Curiosity 1": NSLocalizedString("Mars has the highest mountain in the Solar System, Olympus Mons.", comment: ""),
            "Curiosity 2": NSLocalizedString("The atmosphere of Mars is primarily composed of carbon dioxide.", comment: "")
           ],
           modelName: "mars.usdz"),
    
    // MARK: - Jupiter
    Planet(name: NSLocalizedString("Jupiter", comment: ""),
           morseCode: ".--- ..- .--. .. - . .-.",
           radius: 69911,
           distanceFromSun: 778.5,
           descriptions: [
            "Description 1": NSLocalizedString("The largest planet in the solar system, with a mass more than 300 times that of Earth. Jupiter has a Great Red Spot, a storm larger than Earth that has been active for at least 400 years. It also has 95 known moons, including Europa, which may have a potentially habitable subsurface ocean.", comment: ""),
            "Description 2": NSLocalizedString("In addition to the Great Red Spot, Jupiter has other smaller and faster storms in its turbulent atmosphere. Jupiter's magnetic field is 14 times stronger than Earth's and has a huge magnetosphere that encompasses many of its moons.", comment: ""),
            "Description 3": NSLocalizedString("In Roman mythology, Jupiter was the king of the gods, the god of the sky and thunder. The planet Jupiter, the largest in the solar system, reflects the grandeur and supremacy of the god.", comment: ""),
            "Curiosity 1": NSLocalizedString("Jupiter has a giant red spot, which is an ongoing storm.", comment: ""),
            "Curiosity 2": NSLocalizedString("Jupiter has 95 moons.", comment: "")
           ],
           modelName: "jupiter.usdz"),
    
    // MARK: - Saturn
    Planet(name: NSLocalizedString("Saturn", comment: ""),
           morseCode: "... .- - ..- .-. -. ",
           radius: 58232,
           distanceFromSun: 1433.5,
           descriptions: [
            "Description 1": NSLocalizedString("It is famous for its extensive ring system, composed of ice and rock particles. Saturn's largest moon, Titan, is larger than Mercury and has a thick atmosphere and surface lakes of liquid methane.", comment: ""),
            "Description 2": NSLocalizedString("In addition to Titan, Saturn has 83 known moons. The planet's composition is mainly hydrogen and helium, and it has a density lower than water, meaning it could float in a hypothetical ocean large enough to hold it.", comment: ""),
            "Description 3": NSLocalizedString("In Roman mythology, Saturn was the god of agriculture and harvest. He was often associated with the Greek god Cronus, the god of time. The planet Saturn, with its majestic rings, symbolizes the god's agricultural and time aspects.", comment: ""),
            "Curiosity 1": NSLocalizedString("Saturn is primarily composed of hydrogen and helium.", comment: ""),
            "Curiosity 2": NSLocalizedString("Saturn is the second-largest planet in the Solar System.", comment: "")
           ],
           modelName: "saturn.usdz"),

    // MARK: - Uranus
    Planet(name: NSLocalizedString("Uranus", comment: ""),
           morseCode: "..- .-. .- -. ..- ...",
           radius: 25362,
           distanceFromSun: 2872.5,
           descriptions: [
            "Description 1": NSLocalizedString("A gas giant with a unique feature: it rotates on its side with an axial tilt of 98 degrees. Its atmosphere contains methane, giving it a bluish color. Uranus has 27 known moons, the most famous being Titania and Oberon.", comment: ""),
            "Description 2": NSLocalizedString("Uranus has a faint ring system and a magnetic field that is tilted almost 60 degrees from its axis of rotation. The extreme axial tilt causes extreme seasonal variations, with each pole experiencing 42 years of continuous sunlight or darkness.", comment: ""),
            "Description 3": NSLocalizedString("In Roman mythology, Uranus was personified as the god of the sky, the primordial being who symbolized the heavens. The planet Uranus, being one of the most distant and mysterious planets, represents the infinite sky and the mysteries of the universe.", comment: ""),
            "Curiosity 1": NSLocalizedString("Uranus is tilted 98 degrees on its axis.", comment: ""),
            "Curiosity 2": NSLocalizedString("Uranus is the third-largest planet in the Solar System.", comment: "")
           ],
           modelName: "uranus.usdz"),

    // MARK: - Neptune
    Planet(name: NSLocalizedString("Neptune", comment: ""),
           morseCode: "-. . .--. - ..- -. .",
           radius: 24622,
           distanceFromSun: 4495.1,
           descriptions: [
            "Description 1": NSLocalizedString("The farthest planet from the Sun, known for its intense blue color and strong winds, which can reach speeds of over 2000 km/h. Neptune has 14 known moons, the largest being Triton, which orbits the planet in the opposite direction of Neptune's rotation.", comment: ""),
            "Description 2": NSLocalizedString("In addition to its powerful winds, Neptune also has a storm known as the Great Dark Spot, similar to Jupiter’s Great Red Spot, but it seems to appear and disappear over time. Neptune also has a ring system, although it is much fainter than Saturn’s.", comment: ""),
            "Description 3": NSLocalizedString("In Roman mythology, Neptune was the god of the sea, responsible for governing the waters and the storms. The planet Neptune, with its deep blue color, symbolizes the power and mysteries of the ocean.", comment: ""),
            "Curiosity 1": NSLocalizedString("Neptune has 14 moons.", comment: ""),
            "Curiosity 2": NSLocalizedString("Neptune has the strongest winds in the Solar System, reaching speeds of over 2,000 km/h.", comment: "")
           ],
           modelName: "neptune.usdz"),
]
