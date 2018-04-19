import Foundation

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
    public private(set) var scores: [ScoreType]
    
    public init(_ name: String, icon: String, scores: [ScoreType] ) {
        self.name = name
        self.icon = icon
        self.scores = scores
    }
}
