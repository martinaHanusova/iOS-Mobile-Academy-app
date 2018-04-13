//
//  Model.swift
//  homework3
//
//  Created by Martina Hanusova on 02.04.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import Foundation

// MARK: - Score

public protocol ScoreType: Codable {
    var name: String { get }
    var value: Int { get }
    var emoji: String { get }
}

// MARK: - Person

public protocol PersonType: Codable {
    var name: String { get }
    var icon: String { get }
    var scores: [ScoreType] { get }
}

public class Score: ScoreType, Codable {
    public private(set) var value: Int
    public private(set) var emoji: String
    public var name: String {
        get {
            return emoji + " skóre"
        }
    }
    
    public init(_ value: Int, _ emoji: String) {
        self.value = value
        self.emoji = emoji
    }
}

public class Person: Codable, PersonType {
    public private(set) var id: Int
    public private(set) var name: String
    public private(set) var icon: String
    public private(set) var scores: [ScoreType]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case icon = "icon"
        case scores = "scores"
    }
    
    public init(id: Int, _ name: String, icon: String, scores: [Score] ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.scores = scores
    }
    
    public convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id: Int = try container.decode(Int.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let icon: String = try container.decode(String.self, forKey: .icon)
        let scores: [Score] = try container.decode([Score].self, forKey: .scores)
        
        self.init(id: id, name, icon: icon, scores: scores)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(icon, forKey: .icon)
        try container.encode(scores as! [Score], forKey: .scores)

    }
}

public class Login: Encodable {
    let email: String
    let password: String
    
    init(_ email: String,_ password: String) {
        self.email = email
        self.password = password
    }
}

public class AccountCredentials: Decodable {
    let accountId: Int
    let accessToken: String
    
    init(accountId: Int, accessToken: String) {
        self.accountId = accountId
        self.accessToken = accessToken
    }
}

/*
public class PersonFailing: PersonType {
    public private(set) var id: Int
    public private(set) var name: String
    public private(set) var icon: String
    public private(set) var scores: [ScoreType]
    
    public init(id: Int, _ name: String, icon: String, scores: [ScoreType] ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.scores = scores
    }
}
 */

