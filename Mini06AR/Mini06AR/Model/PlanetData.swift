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
    
    //MARK: - SOL
    Planet(name: "Sol",
           imageName: "sun",
           radius: 696340.0,
           distanceFromSun: 0.0,
           descriptions: [
               "Descrição": "A estrela no centro do Sistema Solar, responsável por fornecer luz e calor à Terra.",
               "Curiosidade 1": "O Sol é composto principalmente por hidrogênio e hélio.",
               "Curiosidade 2": "A temperatura na superfície do Sol é de cerca de 15 milhões de graus Celsius."
           ]),
    
    //MARK: - Mercúrio

    Planet(name: "Mercúrio",
           imageName: "mercury",
           radius: 2439.7,
           distanceFromSun: 57.9,
           descriptions: [
               "Descrição": "O menor planeta do Sistema Solar e o mais próximo do Sol.",
               "Curiosidade 1": "Mercúrio não tem atmosfera significativa para reter o calor.",
               "Curiosidade 2": "A superfície de Mercúrio é coberta de crateras."
           ]),
    
    //MARK: - Vênus

    Planet(name: "Vênus",
           imageName: "venus",
           radius: 6051.8,
           distanceFromSun: 108.2,
           descriptions: [
               "Descrição": "O segundo planeta do Sistema Solar e o mais quente.",
               "Curiosidade 1": "A atmosfera de Vênus é composta principalmente de dióxido de carbono.",
               "Curiosidade 2": "Vênus possui uma temperatura superficial média de 475 graus Celsius."
           ]),
    
    //MARK: - Terra

    Planet(name: "Terra",
           imageName: "earth",
           radius: 6371.0,
           distanceFromSun: 149.6,
           descriptions: [
               "Descrição": "Nosso lar, o terceiro planeta do Sistema Solar.",
               "Curiosidade 1": "A Terra é o único planeta conhecido por abrigar vida.",
               "Curiosidade 2": "A superfície da Terra é composta por 71% de água."
           ]),
    
    //MARK: - Marte

    Planet(name: "Marte",
           imageName: "mars",
           radius: 3389.5,
           distanceFromSun: 227.9,
           descriptions: [
               "Descrição": "O Planeta Vermelho, o quarto do Sistema Solar.",
               "Curiosidade 1": "Marte possui a montanha mais alta do Sistema Solar, Olympus Mons.",
               "Curiosidade 2": "A atmosfera de Marte é composta principalmente de dióxido de carbono."
           ]),
    
    //MARK: - Júpiter

    Planet(name: "Júpiter",
           imageName: "jupiter",
           radius: 69911,
           distanceFromSun: 778.5,
           descriptions: [
               "Descrição": "O maior planeta do Sistema Solar, o quinto a partir do Sol.",
               "Curiosidade 1": "Júpiter tem uma mancha vermelha gigante, que é uma tempestade em curso.",
               "Curiosidade 2": "Júpiter tem mais de 79 luas."
           ]),
    
    //MARK: - Saturno

    Planet(name: "Saturno",
           imageName: "saturn",
           radius: 58232,
           distanceFromSun: 1433.5,
           descriptions: [
               "Descrição": "Conhecido pelos seus anéis impressionantes, é o sexto planeta do Sistema Solar.",
               "Curiosidade 1": "Os anéis de Saturno são feitos principalmente de gelo e rocha.",
               "Curiosidade 2": "Saturno tem 145 luas conhecidas."
           ]),
    
    //MARK: - Urano

    Planet(name: "Urano",
           imageName: "uranus",
           radius: 25362,
           distanceFromSun: 2872.5,
           descriptions: [
               "Descrição": "O sétimo planeta do Sistema Solar, conhecido pela sua cor azulada.",
               "Curiosidade 1": "Urano gira de lado, com seu eixo de rotação quase paralelo ao plano de sua órbita.",
               "Curiosidade 2": "Urano tem 27 luas conhecidas."
           ]),
    
    //MARK: - Netuno

    Planet(name: "Netuno",
           imageName: "neptune",
           radius: 24622,
           distanceFromSun: 4495.1,
           descriptions: [
               "Descrição": "O oitavo planeta do Sistema Solar, conhecido por seus ventos fortes.",
               "Curiosidade 1": "Netuno tem os ventos mais rápidos do Sistema Solar, atingindo até 2.100 km/h.",
               "Curiosidade 2": "Netuno tem 14 luas conhecidas."
           ])
]
