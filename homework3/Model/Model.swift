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

public class Person: Codable {
    public private(set) var id: Int
    public private(set) var name: String
    public private(set) var icon: String
    public private(set) var scores: [Score]
    
    public init(id: Int, _ name: String, icon: String, scores: [Score] ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.scores = scores
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

