//
//  ParticipantsListVC.swift
//  homework3
//
//  Created by Martina Hanusova on 31.03.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit

class ParticipantListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var viewModel: ParticipantsVM
    
    init(viewModel: ParticipantsVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Seznam účastníků"
        let table = UITableView(frame: CGRect.infinite, style: .grouped)
        let loadingView = LoadingView()
        let participantDetailVC = ParticipantDetailVC()
        
        
        table.delegate = self
        table.dataSource = self
        table.register(ParticipantCell.self, forCellReuseIdentifier: "cell")
        table.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        
        viewModel.didUpdateModel = { model in
            table.reloadData()
            loadingView.removeFromSuperview()
            table.frame = self.view.frame
            self.view.addSubview(table)
        }
        
        viewModel.willUpdateModel = {
            loadingView.setup()
            loadingView.frame = self.view.frame
            self.view.addSubview(loadingView)
        }
            
        viewModel.willLoadDetail = {
            participantDetailVC.content = nil
            self.navigationController?.pushViewController(participantDetailVC, animated: true)
        }
        
        viewModel.didLoadDetail = {
            participantDetailVC.content = $0
        }
        
        viewModel.loadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = viewModel.modelForRow(inSection: indexPath.section, atIdx: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? ParticipantCell(style: .subtitle, reuseIdentifier: nil)
        (cell as! ParticipantCell).person = data
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection: Int) -> String? {
        return viewModel.modelForSection(titleForHeaderInSection).header
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection: Int) -> String? {
        return viewModel.modelForSection(titleForFooterInSection).footer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.rowSelected(inSection: indexPath.section, atIdx: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



