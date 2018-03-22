
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
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = data.name
        cell.imageView?.image = UIImage(named: data.icon)
        cell.detailTextLabel?.text = scoreToString(scores: data.scores)
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
    
    private func scoreToString(scores: [ScoreType]) -> String {
        let scoresSorted = scores.sorted(by: {score1, score2 in
            return score1.value > score2.value
        })
        var retVal = ""
        for score in scoresSorted {
            if score.value > 0 {
            retVal += score.name + " \(score.value)   "
            }
        }
        return retVal
    }
}
let container = Container()
let model = ViewModel()
let tableSource = TableViewSource(model)

let table = UITableView(frame: container.content.bounds, style: .grouped)
table.delegate = tableSource
table.dataSource = tableSource

model.didUpdateModel = {model in table.reloadData()}

container.content.addSubview(table)
table.autoresizingMask = [.flexibleWidth,.flexibleHeight]

model.loadData()


