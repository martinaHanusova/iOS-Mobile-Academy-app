//
//  ParticipantsListVC.swift
//  homework3
//
//  Created by Martina Hanusova on 31.03.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit

class ParticipantListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var model: ViewModel = ViewModel()
    
    override func loadView() {
        
        let table = UITableView(frame: CGRect.infinite, style: .grouped)
        
        table.delegate = self
        table.dataSource = self
        table.register(ParticipantCell.self, forCellReuseIdentifier: "cell")
        
        model.didUpdateModel = {model in table.reloadData()}

        table.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view = table
        model.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Seznam účastníků"
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = model.modelForRow(inSection: indexPath.section, atIdx: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? ParticipantCell(style: .subtitle, reuseIdentifier: nil)
        (cell as! ParticipantCell).person = data
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = model.modelForRow(inSection: indexPath.section, atIdx: indexPath.row)
        
        self.navigationController?.pushViewController(ParticipantDetailVC(person: data), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



