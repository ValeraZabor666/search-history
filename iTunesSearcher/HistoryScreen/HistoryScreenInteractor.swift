//
//  HistoryScreenInteractor.swift
//  iTunesHistoryer
//
//  Created by Captain Kidd on 01.12.2021.
//

import Foundation

protocol HistoryScreenInteractorProtocol {
    var presenter: HistoryScreenPresenterProtocol? { get set }

}

class HistoryScreenInteractor: HistoryScreenInteractorProtocol {
    
    
    var presenter: HistoryScreenPresenterProtocol?
    
}
