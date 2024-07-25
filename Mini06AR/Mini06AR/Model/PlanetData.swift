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

// Ajuste esses valores conforme necessário
let baseDistance: CGFloat = 2.5 // Distância base para o Sol
let distanceMultiplier: CGFloat = 5 // Multiplicador para ampliar as distâncias

// Adicione velocidades de rotação variáveis (em segundos para uma volta completa)
let planetSpeeds: [String: Double] = [
    "Mercúrio": 0.2, // Velocidade de rotação para Mercúrio (em segundos)
    "Vênus": 0.3,
    "Terra": 0.5,
    "Marte": 0.6,
    "Júpiter": 1.0,
    "Saturno": 1.2,
    "Urano": 1.5,
    "Netuno": 1.8
]

let planets = [
    
    //MARK: - SOL
    Planet(name: "Sol",
           imageName: "sun",
           radius: 696340.0,
           distanceFromSun: 10 / 1.6,
           descriptions: [
               "Descrição": "A estrela no centro do Sistema Solar, responsável por fornecer luz e calor à Terra.",
               "Curiosidade 1": "O Sol é composto principalmente por hidrogênio e hélio.",
               "Curiosidade 2": "A temperatura na superfície do Sol é de cerca de 15 milhões de graus Celsius."
           ],
           modelName: "Sun.usdz"),
    
    //MARK: - Mercúrio

    Planet(name: "Mercúrio",
           imageName: "mercury",
           radius: 2439.7,
           distanceFromSun: 20 / 1.6,
           descriptions: [
               "Descrição": "O menor planeta do Sistema Solar e o mais próximo do Sol.",
               "Curiosidade 1": "Mercúrio não tem atmosfera significativa para reter o calor.",
               "Curiosidade 2": "A superfície de Mercúrio é coberta de crateras."
           ],
           modelName: "Mercury.usdz"),
    
    //MARK: - Vênus

    Planet(name: "Vênus",
           imageName: "venus",
           radius: 6051.8,
           distanceFromSun: 30 / 1.6,
           descriptions: [
               "Descrição": "O segundo planeta do Sistema Solar e o mais quente.",
               "Curiosidade 1": "A atmosfera de Vênus é composta principalmente de dióxido de carbono.",
               "Curiosidade 2": "Vênus possui uma temperatura superficial média de 475 graus Celsius."
           ],
           modelName: "Venus.usdz"),
    
    //MARK: - Terra

    Planet(name: "Terra",
           imageName: "earth",
           radius: 6371.0,
           distanceFromSun: 40 / 1.6,
           descriptions: [
               "Descrição": "Nosso lar, o terceiro planeta do Sistema Solar.",
               "Curiosidade 1": "A Terra é o único planeta conhecido por abrigar vida.",
               "Curiosidade 2": "A superfície da Terra é composta por 71% de água."
           ],
           modelName: "Earth.usdz"),
    
    //MARK: - Marte

    Planet(name: "Marte",
           imageName: "mars",
           radius: 3389.5,
           distanceFromSun: 50 / 1.6,
           descriptions: [
               "Descrição": "O Planeta Vermelho, o quarto do Sistema Solar.",
               "Curiosidade 1": "Marte possui a montanha mais alta do Sistema Solar, Olympus Mons.",
               "Curiosidade 2": "A atmosfera de Marte é composta principalmente de dióxido de carbono."
           ],
           modelName: "Mars.usdz"),
    
    //MARK: - Júpiter

    Planet(name: "Júpiter",
           imageName: "jupiter",
           radius: 69911,
           distanceFromSun: 60 / 1.6,
           descriptions: [
               "Descrição": "O maior planeta do Sistema Solar, o quinto a partir do Sol.",
               "Curiosidade 1": "Júpiter tem uma mancha vermelha gigante, que é uma tempestade em curso.",
               "Curiosidade 2": "Júpiter tem mais de 79 luas."
           ],
           modelName: "Jupiter.usdz"),
    
    //MARK: - Saturno

    Planet(name: "Saturno",
           imageName: "saturn",
           radius: 58232,
           distanceFromSun: 70 / 1.6,
           descriptions: [
               "Descrição": "Conhecido pelos seus anéis impressionantes, é o sexto planeta do Sistema Solar.",
               "Curiosidade 1": "Os anéis de Saturno são feitos principalmente de gelo e rocha.",
               "Curiosidade 2": "Saturno tem 145 luas conhecidas."
           ],
           modelName: "Saturn.usdz"),
    
    //MARK: - Urano

    Planet(name: "Urano",
           imageName: "uranus",
           radius: 25362,
           distanceFromSun: 80 / 1.6,
           descriptions: [
               "Descrição": "O sétimo planeta do Sistema Solar, conhecido pela sua cor azulada.",
               "Curiosidade 1": "Urano gira de lado, com seu eixo de rotação quase paralelo ao plano de sua órbita.",
               "Curiosidade 2": "Urano tem 27 luas conhecidas."
           ],
           modelName: "Uranus.usdz"),
    
    //MARK: - Netuno

    Planet(name: "Netuno",
           imageName: "neptune",
           radius: 24622,
           distanceFromSun: 90 / 1.6,
           descriptions: [
               "Descrição": "O oitavo planeta do Sistema Solar, conhecido por seus ventos fortes.",
               "Curiosidade 1": "Netuno tem os ventos mais rápidos do Sistema Solar, atingindo até 2.100 km/h.",
               "Curiosidade 2": "Netuno tem 14 luas conhecidas."
           ],
           modelName: "Neptune.usdz")
]
