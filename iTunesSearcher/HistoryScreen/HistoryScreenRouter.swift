//
//  HistoryScreenRouter.swift
//  iTunesHistoryer
//
//  Created by Captain Kidd on 01.12.2021.
//

import Foundation
import UIKit

typealias HistoryEntryPoint = HistoryScreenViewControllerProtocol & UIViewController

protocol HistoryScreenRouterProtocol {
    
    var entry: HistoryEntryPoint? { get }
    static func start() -> HistoryScreenRouterProtocol
    
    func searchFromHistory() 
}

class HistoryScreenRouter: HistoryScreenRouterProtocol {
    
    var entry: HistoryEntryPoint?
    
    static func start() -> HistoryScreenRouterProtocol {
        let router = HistoryScreenRouter()
        
        var view: HistoryScreenViewControllerProtocol = HistoryScreenViewController()
        var presenter: HistoryScreenPresenterProtocol = HistoryScreenPresenter()
        var interactor: HistoryScreenInteractorProtocol = HistoryScreenInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view as? HistoryEntryPoint
        
        return router
    }
    
    func searchFromHistory() {
        entry?.tabBarController?.selectedIndex = 0
    }
}
