//
//  RMCharacter.swift
//  RickAndMortyApp
//
//  Created by Dimitrios Gkarlemos on 14/07/2023.
//

import Foundation

// MARK: - RMCharacter
struct RMCharacter: Codable {
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: String
    let type: String
    let gender: RMCharacterGender
    let origin: RMOrigin
    let location: RMSingleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - RMOrigin
struct RMOrigin: Codable {
    let name: String
    let url: String
}

// MARK: - RMSingleLocation
struct RMSingleLocation: Codable {
    let name: String
    let url: String
}

// MARK: - enum RMCharacterStatus
enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

// MARK: - enum RMCharacterGender
enum RMCharacterGender: String, Codable {
    case male = "Male"
    case genderless = "Genderless"
    case female = "Female"
    case unknown = "unknown"
}
