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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Seznam účastníků"
        let table = UITableView(frame: CGRect.infinite, style: .grouped)
        let loadingView = LoadingView()
        loadingView.setup()
        
        table.delegate = self
        table.dataSource = self
        table.register(ParticipantCell.self, forCellReuseIdentifier: "cell")
        table.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        
        model.didUpdateModel = { model in
            table.reloadData()
            loadingView.removeFromSuperview()
            table.frame = self.view.frame
            self.view.addSubview(table)
        }
        
        
        loadingView.frame = view.frame
        view.addSubview(loadingView)
        var timer : Timer?
        timer = Timer.scheduledTimer(
        withTimeInterval: 0.002, repeats: false) { _ in
            self.view.addSubview(loadingView)
        }
        model.loadData()
        timer?.invalidate()
        timer = nil
        
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
        
        self.navigationController?.pushViewController(ParticipantDetailVC(person: data, model: model), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



