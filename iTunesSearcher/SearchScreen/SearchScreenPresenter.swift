//
//  SearchScreenPresenter.swift
//  iTunesSearcher
//
//  Created by Captain Kidd on 01.12.2021.
//

import Foundation

protocol SearchScreenPresenterProtocol {
    var router: SearchScreenRouterProtocol? { get set }
    var interactor: SearchScreenInteractorProtocol? { get set }
    var view: SearchScreenViewControllerProtocol? { get set }
    
    func getAlbums(_ search: String)
    func updateAlbums(_ data: [Album])
    func openDetails()
    func saveToHistory(_ text: String)
    func showError()
}

class SearchScreenPresenter: SearchScreenPresenterProtocol {
    
    var router: SearchScreenRouterProtocol?
    var interactor: SearchScreenInteractorProtocol?
    var view: SearchScreenViewControllerProtocol?
    
    func getAlbums(_ search: String) {
        interactor?.loadData(search)
    }
    
    func updateAlbums(_ data: [Album]) {
        view?.reloadCollection(data)
    }
    
    func openDetails() {
        router?.openDetails()
    }
    
    func saveToHistory(_ text: String) {
        interactor?.saveHistory(text)
    }
    
    func showError() {
        view?.displayError()
    }
}
