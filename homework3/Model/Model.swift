//
//  Model.swift
//  homework3
//
//  Created by Martina Hanusova on 02.04.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import Foundation

// MARK: - Score

public protocol ScoreType {
    var name: String { get }
    var value: Int { get }
}

// MARK: - Person

public protocol PersonType {
    var name: String { get }
    var icon: String { get }
    var scores: [ScoreType] { get }
}

public class Score: ScoreType {
    
    public private(set) var name: String
    public private(set) var value: Int
    
    public init(_ name: String, _ value: Int) {
        self.name = name
        self.value = value
    }
}

public class Person: PersonType {
    public private(set) var name: String
    public private(set) var icon: String
    public private(set) var contact: (slackId: String, email: String, phone: String)
    public private(set) var position: String
    public private(set) var scores: [ScoreType]
    
    public init(_ name: String, icon: String, scores: [ScoreType] ) {
        self.name = name
        self.icon = icon
        self.contact = ("3241", "ninja.junior@mobile-academy.cz", "+420 123 432 654")
        self.position = "Swift ninja junior"
        self.scores = scores
    }
    
    func toBusinessCardContent() -> BusinessCardContent {
        return BusinessCardContent(photoName: icon + "-large", name: name, slackUserId: contact.slackId, email: contact.email, phone: contact.phone, position: position, scores: scores)
    }
}

