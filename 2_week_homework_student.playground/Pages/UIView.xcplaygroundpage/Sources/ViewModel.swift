import Foundation

public protocol ViewModelType {
    
    typealias Section = (header: String?,rows: [Person], footer: String?)
    typealias Model = [Section]
    
    var model: Model {get}
    var didUpdateModel: ((Model) -> Void)? {get set}
    func numberOfSections() -> Int
    func numberOfRows(inSection: Int) -> Int
    func modelForSection(_ section: Int) -> Section
    func modelForRow(inSection: Int, atIdx: Int) -> Person
}

extension ViewModelType {
    public func numberOfSections() -> Int {
        return model.count
    }
    
    public func numberOfRows(inSection: Int) -> Int {
        return model[inSection].rows.count
    }
    
    public func modelForSection(_ section: Int) -> Section {
        return model[section]
    }
    
    public func modelForRow(inSection: Int, atIdx: Int) -> Person {
        return model[inSection].rows[atIdx]
    }
    
}

public class ViewModel: ViewModelType {
    
    public init() {}
    
    public private(set) var model: ViewModelType.Model = [] {
        didSet {
            didUpdateModel?(model)
        }
    }
    public var didUpdateModel: ((Model) -> Void)?
    
    public func loadData() {
        func randomScores() -> [Score] {
            let scoreIcons = ["🍺", "☕️", "🍵", "🍛"]
            var retVal: [Score] = []
            for icon in scoreIcons {
                retVal.append(Score(icon, Int(arc4random_uniform(10))))
            }
            return retVal
        }
        
        let persons = [
            Person("Adam", icon: "adam", scores: randomScores()),
            Person("Adam", icon: "adam", scores: randomScores()),
            Person("Adam", icon: "adam", scores: randomScores()),
            Person("Adam", icon: "adam", scores: randomScores()),
            Person("Adam", icon: "adam", scores: randomScores()),
            Person("Adam", icon: "adam", scores: randomScores()),
            Person("Adam", icon: "adam", scores: randomScores()),
            Person("Adam", icon: "adam", scores: randomScores()),
            Person("Adam", icon: "adam", scores: randomScores()),
            Person("Adam", icon: "adam", scores: randomScores()),
            Person("Adam", icon: "adam", scores: randomScores()),
            ]
        
        model = [ViewModelType.Section(header: "Účastníci", rows: persons, footer: nil)]
    }
}

