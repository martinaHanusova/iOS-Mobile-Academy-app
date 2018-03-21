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
