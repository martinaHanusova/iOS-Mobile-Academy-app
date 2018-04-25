//
//  BusinessCardContent.swift
//  homework3
//
//  Created by Martina Hanusova on 02.04.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import Foundation

/// Modelová třída, která drží data potřebná pro zobrazení vizitky.
public class BusinessCardContent: Codable {
    public let id: Int
    public let name: String
    public let icon: String
    public let slackUserId: String
    public let email: String
    public let phone: String
    public let position: String
    public let scores: [Score]
    
    public init(id: Int, name: String, icon: String, slackUserId: String, email: String, phone: String, position: String, scores: [Score]) {
        self.id = id
        self.name = name
        self.icon = icon
        self.slackUserId = slackUserId
        self.email = email
        self.phone = phone
        self.position = position
        self.scores = scores
    }
    
    enum CodingKeys: String, CodingKey {
        case slackUserId = "slack_id"
        
        case id
        case name
        case icon
        case email
        case phone
        case position
        case scores
        
    }
}
