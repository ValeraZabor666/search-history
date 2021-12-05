//
//  SearchScreenRouter.swift
//  iTunesSearcher
//
//  Created by Captain Kidd on 01.12.2021.
//

import Foundation
import UIKit

typealias SearchEntryPoint = SearchScreenViewControllerProtocol & UIViewController

protocol SearchScreenRouterProtocol {
    
    var entry: SearchEntryPoint? { get }
    static func start() -> SearchScreenRouterProtocol
    
    func openDetails()
}

class SearchScreenRouter: SearchScreenRouterProtocol {
    
    var entry: SearchEntryPoint?
    
    static func start() -> SearchScreenRouterProtocol {
        let router = SearchScreenRouter()
        
        var view: SearchScreenViewControllerProtocol = SearchScreenViewController()
        var presenter: SearchScreenPresenterProtocol = SearchScreenPresenter()
        var interactor: SearchScreenInteractorProtocol = SearchScreenInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view as? SearchEntryPoint
        
        return router
    }
    
    func openDetails() {
        let vc = DetailScreenRouter.start()
        let destVc = vc.entry
        entry?.navigationController?.pushViewController(destVc!, animated: true)
    }
}
