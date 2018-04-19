
import UIKit
//: ## Jak začít
//: Vytvoř modelové třídy `Score` a `Person`, které implementují protokoly `ScoreType` a `PersonType`, které jsou v Sources › Model.
//:
//: Pole `[Person]` bude představovat model pro výslednou tabulku, „nějak“ si ho vygeneruj.
//:
//: Vygenerovaný model zobraz v tableView.
//:
//: Nezapomeň použít reuse a udělat podporu pro rotaci.
//:
//: Počítej s tím, že `scores` každé Person mohou být nesetříděná data o `n` prvcích. Zobraz první 4 největší skóre a skryj taková skóre, která mají hodnotu 0.
//: ## Dál je to na tobě
//: V Resources jsou obličeje tvých „spolužáků“.

class MyCell: UITableViewCell {
    var person: Person? {
        didSet {
            setup()
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        if let person = person {
            textLabel?.text = person.name
            imageView?.image = UIImage(named: person.icon)
            detailTextLabel?.attributedText = scoreToString(scores: person.scores)
            detailTextLabel?.textColor = UIColor.gray
        }
    }
    
    private func scoreToString(scores: [ScoreType]) -> NSMutableAttributedString {
        let scoresSorted = scores.sorted(by: {score1, score2 in
            return score1.value > score2.value
        }).filter {score in
            return score.value > 0
        }
        let retVal = NSMutableAttributedString(string: "")
        for (index, score) in scoresSorted.enumerated() {
            if index < 4 {
                let scoreString = score.name
                let attrs = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 22.0)]
                let attributedName = NSMutableAttributedString(string: scoreString, attributes: attrs)
                let nameString = " \(score.value)   "
                let attributedValue = NSMutableAttributedString(string: nameString)
                retVal.append(attributedValue)
                retVal.append(attributedName)
            }
        }
        return retVal
    }

}

class TableViewSource: NSObject, UITableViewDelegate, UITableViewDataSource  {
    private let model: ViewModel
    init(_ model: ViewModel) {
        self.model = model
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = model.modelForRow(inSection: indexPath.section, atIdx: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? MyCell(style: .subtitle, reuseIdentifier: nil)
        (cell as! MyCell).person = data
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.numberOfSections()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection: Int) -> String? {
        return model.modelForSection(titleForHeaderInSection).header
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection: Int) -> String? {
        return model.modelForSection(titleForFooterInSection).footer
    }
}
let container = Container()
let model = ViewModel()
let tableSource = TableViewSource(model)



let table = UITableView(frame: container.content.bounds, style: .grouped)

table.delegate = tableSource
table.dataSource = tableSource
table.register(MyCell.self, forCellReuseIdentifier: "cell")

model.didUpdateModel = {model in table.reloadData()}

container.content.addSubview(table)
table.autoresizingMask = [.flexibleWidth,.flexibleHeight]

model.loadData()


