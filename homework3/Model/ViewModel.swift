   //
//  ViewModel.swift
//  homework3
//
//  Created by Martina Hanusova on 02.04.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

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
        DispatchQueue.global().async {
            let url = URL(string: "http://emarest.cz.mass-php-1.mit.etn.cz/api/participants?sort=asc")
            let data = try! Data(contentsOf: url!)
            let decoder = JSONDecoder()
            let persons = try! decoder.decode(Array<Person>.self, from: data)
            DispatchQueue.main.async {
                self.model = [ViewModelType.Section(header: nil, rows: persons, footer: nil)]
            }
        }
    }
    
    public func findById(id: Int, onSuccess:@escaping (BusinessCardContent) -> Void) {
        DispatchQueue.global().async {
            let url = URL(string: "http://emarest.cz.mass-php-1.mit.etn.cz/api/participant/\(id)")
            let data = try! Data(contentsOf: url!)
            let decoder = JSONDecoder()
            let content = try! decoder.decode(BusinessCardContent.self, from: data)
            DispatchQueue.main.async {
                onSuccess(content)
            }
        }
    }
    
    public func findByAccountCredentials(account: AccountCredentials, onSuccess:@escaping (BusinessCardContent) -> Void) {
        DispatchQueue.global().async {
            
            let url = URL(string: "http://emarest.cz.mass-php-1.mit.etn.cz/api/account/\(account.accountId)")
            var urlRequest = URLRequest(url: url!)
            urlRequest.addValue(account.accessToken, forHTTPHeaderField: "accessToken")
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest ){ (data, response, error) in
                
                guard let data = data else { return }
                
                let decoder = JSONDecoder()
                
                do {
                    let content = try decoder.decode(BusinessCardContent.self, from: data)
                    DispatchQueue.main.async {
                        onSuccess(content)
                    }
                } catch {
                    print(error)
                }
            }
            dataTask.resume()
        }
    }
   

    
    public func findByName(name: String) -> Person? {
        var person: Person?
        for a in model {
            for p in a.rows {
                if p.name == name {
                    person = p
                }
            }
        }
        return person
    }
}


