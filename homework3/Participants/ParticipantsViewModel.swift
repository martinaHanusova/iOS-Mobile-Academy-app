//
//  ParticipantsViewModel.swift
//  homework3
//
//  Created by Martina Hanusova on 16.04.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import Foundation

protocol ParticipantsVM {
    
    // Should be called, when list data begin to load
    var listLoading: ()->Void { get set }
    
    // Should be called right after participant list were loaded
    var listLoaded: ([PersonType])->Void { get set }
    
    // Should be called, when detail loading. True = began. False = finished with error, or when participant should be closed for now
    var detailLoading: (Bool)->Void { get set }
    
    // Should be called, when detail is available and should be displayed
    var detailLoaded: (PersonDetailType)->Void { get set }
    
    // Should return participants list
    func rowCount() -> Int
    
    // Should return participant data for list view - rowNumber is zero indexed
    func modelForRow(rowNumber: Int) -> PersonType
    
    // Method should be called when someone selects given participant. rowNumber is same as participants
    func rowSelected(rowNumber: Int) -> Void
    
    // Method will be called, when detail were dismiss. Be aware, as this method should hit detailLoading with false argument.
    // You should call it every time, when detail is dismissed at all (for navbar see https://stackoverflow.com/a/27715660/7711163)
    func detailDismiss() -> Void
    
    // Method to "start"
    func loadData() -> Void
}

class ParticipantsViewModel: ParticipantsVM {
 
    var listLoading: ()->Void { get set }
    var listLoaded: ([PersonType])->Void { get set }
    var detailLoading: (Bool)->Void { get set }
    
    func rowCount() -> Int {
        
    }
    
    func modelForRow(rowNumber: Int) -> PersonType {
        
    }
    
    func rowSelected(rowNumber: Int) -> Void {
        
    }
    
    func detailDismiss() -> Void {
        
    }
    
    func loadData() -> Void {
        
    }
    
}


