//
//  DetailScreenRouter.swift
//  iTunesSearcher
//
//  Created by Captain Kidd on 01.12.2021.
//

import Foundation
import UIKit

typealias DetailEntryPoint = DetailScreenViewControllerProtocol & UIViewController

protocol DetailScreenRouterProtocol {
    
    var entry: DetailEntryPoint? { get }
    static func start() -> DetailScreenRouterProtocol
    
}

class DetailScreenRouter: DetailScreenRouterProtocol {
    
    var entry: DetailEntryPoint?
    
    static func start() -> DetailScreenRouterProtocol {
        let router = DetailScreenRouter()
        
        var view: DetailScreenViewControllerProtocol = DetailScreenViewController()
        var presenter: DetailScreenPresenterProtocol = DetailScreenPresenter()
        var interactor: DetailScreenInteractorProtocol = DetailScreenInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view as? DetailEntryPoint
        
        return router
    }
}
