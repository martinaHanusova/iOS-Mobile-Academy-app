   //
//  ViewModel.swift
//  homework3
//
//  Created by Martina Hanusova on 02.04.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import Foundation

public protocol ParticipantsVM {
    
    typealias Section = (header: String?,rows: [Person], footer: String?)
    typealias Model = [Section]
    
    var model: Model {get}
    var didUpdateModel: ((Model) -> Void)? { get set }
    // Should be called, when list data begin to load
    var willUpdateModel: (()->Void)? { get set }
    var didFailedLoadingModel: (() -> Void)? { get set }
    // Should be called, when detail loading. True = began. False = finished with error, or when participant should be closed for now
    var willLoadDetail: (()->Void)? { get set }
    // Should be called, when detail is available and should be displayed
    var didLoadDetail: ((BusinessCardContent?)->Void)? { get set }
    var didFailedLoadingDetail: (() -> Void)? { get set }
    func numberOfSections() -> Int
    func numberOfRows(inSection: Int) -> Int
    func modelForSection(_ section: Int) -> Section
    func modelForRow(inSection: Int, atIdx: Int) -> Person
    // Method should be called when someone selects given participant. rowNumber is same as participants
    func rowSelected(inSection: Int, atIdx: Int) -> Void
    func detailDismiss() -> Void
    func loadData() -> Void
}

extension ParticipantsVM {
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

public class ViewModelParticipants: ParticipantsVM {
    
    public private(set) var model: ParticipantsVM.Model = [] {
        didSet {
            didUpdateModel?(model)
        }
    }
    public var didUpdateModel: ((Model) -> Void)?
    public var willUpdateModel: (()->Void)?
    public var didFailedLoadingModel: (() -> Void)?
    public var willLoadDetail: (()->Void)?
    public var didLoadDetail: ((BusinessCardContent?)->Void)?
    public var didFailedLoadingDetail: (() -> Void)?
    public private(set) var displayedDetail: BusinessCardContent? {
        didSet {
            self.didLoadDetail?((displayedDetail))
        }
    }
    private let baseUrl = "http://emarest.cz.mass-php-1.mit.etn.cz/api/"
    
    public func loadData() {
        self.willUpdateModel?()
        DispatchQueue.global().async {
            let url = URL(string: "\(self.baseUrl)participants?sort=asc")
            do {
                let data = try Data(contentsOf: url!)
                let decoder = JSONDecoder()
                let persons = try decoder.decode(Array<Person>.self, from: data)
                DispatchQueue.main.async {
                    self.model = [ParticipantsVM.Section(header: nil, rows: persons, footer: nil)]
                }
            }
                catch {
                    DispatchQueue.main.async {
                        self.didFailedLoadingModel?()
                    }
                }
        }
    }
    
    public func rowSelected(inSection: Int, atIdx: Int) -> Void {
        let person = model[inSection].rows[atIdx]
        self.willLoadDetail?()
        DispatchQueue.global().async {
            let url = URL(string: "\(self.baseUrl)participant/\(person.id)")
            do {
                let data = try Data(contentsOf: url!)
                let decoder = JSONDecoder()
                let content = try decoder.decode(BusinessCardContent.self, from: data)
                DispatchQueue.main.async {
                    self.displayedDetail = content
                }
            } catch {
                self.didFailedLoadingDetail?()
            }
        }
    }
    
    public func detailDismiss() -> Void {
        displayedDetail = nil
    }
}

