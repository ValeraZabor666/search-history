//
//  HistoryScreenPresenter.swift
//  iTunesHistoryer
//
//  Created by Captain Kidd on 01.12.2021.
//

import Foundation

protocol HistoryScreenPresenterProtocol {
    var router: HistoryScreenRouterProtocol? { get set }
    var interactor: HistoryScreenInteractorProtocol? { get set }
    var view: HistoryScreenViewControllerProtocol? { get set }
    
    func searchFromHistory()
}

class HistoryScreenPresenter: HistoryScreenPresenterProtocol {
    
    var router: HistoryScreenRouterProtocol?
    var interactor: HistoryScreenInteractorProtocol?
    var view: HistoryScreenViewControllerProtocol?
    
    func searchFromHistory() {
        router?.searchFromHistory()
    }
}
