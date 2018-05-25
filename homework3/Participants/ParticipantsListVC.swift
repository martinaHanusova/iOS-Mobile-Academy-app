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
        
        
        viewModel.didUpdateModel = { [weak self] model in
            table.reloadData()
            loadingView.removeFromSuperview()
            if let strongSelf = self {
                table.frame = strongSelf.view.frame
                strongSelf.view.addSubview(table)
            }
        }
        
        viewModel.willUpdateModel = { [weak self] in
            loadingView.setup()
            if let strongSelf = self {
            loadingView.frame = strongSelf.view.frame
            strongSelf.view.addSubview(loadingView)
            }
        }
            
        viewModel.willLoadDetail = { [weak self] in
            participantDetailVC.content = nil
            self?.navigationController?.pushViewController(participantDetailVC, animated: true)
        }
        
        viewModel.didLoadDetail = {
            participantDetailVC.content = $0
        }
        
        viewModel.didFailedLoadingModel = { [weak self] in
            self?.displayAlert(handler: {self?.viewModel.loadData()}, buttonTitle: "Try again")
        }
        
        viewModel.didFailedLoadingDetail = { [weak self] in
            self?.displayAlert(handler: {self?.navigationController?.popViewController(animated: true)}, buttonTitle: "OK")
        }
        viewModel.loadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = viewModel.modelForRow(inSection: indexPath.section, atIdx: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? ParticipantCell(style: .subtitle, reuseIdentifier: nil)
        (cell as! ParticipantCell).setup(person: data)
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
    
    func displayAlert(handler: @escaping () -> Void, buttonTitle: String) {
        let alert = UIAlertController(title: "Ups. Unable to download data", message: "Check your internet conection.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: {action in handler()}))
        self.present(alert, animated: true, completion: nil)
    }
    
}



