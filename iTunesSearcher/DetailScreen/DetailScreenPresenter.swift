//
//  DetailScreenPresenter.swift
//  iTunesSearcher
//
//  Created by Captain Kidd on 01.12.2021.
//

import Foundation

protocol DetailScreenPresenterProtocol {
    var router: DetailScreenRouterProtocol? { get set }
    var interactor: DetailScreenInteractorProtocol? { get set }
    var view: DetailScreenViewControllerProtocol? { get set }
    
    func loadDetails()
    func updateDetails(_ tracks: [String])
    func showError()
}

class DetailScreenPresenter: DetailScreenPresenterProtocol {
    
    var router: DetailScreenRouterProtocol?
    var interactor: DetailScreenInteractorProtocol?
    var view: DetailScreenViewControllerProtocol?
    
    func loadDetails() {
        interactor?.loadData()
    }
    
    func updateDetails(_ tracks: [String]) {
        view?.updateCollection(tracks)
    }
    
    func showError() {
        view?.displayError()
    }
    
}
