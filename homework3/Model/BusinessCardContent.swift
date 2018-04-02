//
//  BusinessCardContent.swift
//  homework3
//
//  Created by Martina Hanusova on 02.04.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import Foundation

/// Modelová třída, která drží data potřebná pro zobrazení vizitky.
public class BusinessCardContent {
    public let photoName: String
    public let name: String
    public let slackUserId: String
    public let email: String
    public let phone: String
    public let position: String
    public let scores: [ScoreType]
    
    public init(photoName: String, name: String, slackUserId: String, email: String, phone: String, position: String, scores: [ScoreType]) {
        self.photoName = photoName
        self.name = name
        self.slackUserId = slackUserId
        self.email = email
        self.phone = phone
        self.position = position
        self.scores = scores
    }
}
