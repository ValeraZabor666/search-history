//
//  SearchScreenInteractor.swift
//  iTunesSearcher
//
//  Created by Captain Kidd on 01.12.2021.
//

import Foundation
import RealmSwift

protocol SearchScreenInteractorProtocol {
    var presenter: SearchScreenPresenterProtocol? { get set }

    func loadData(_ search: String)
    func saveHistory(_ line: String)
}

class SearchScreenInteractor: SearchScreenInteractorProtocol {
    
    var presenter: SearchScreenPresenterProtocol?
    
    func saveHistory(_ line: String) {
        let realm = try! Realm()
        let newSearch = History()
        newSearch.searching = line
        
        try! realm.write {
            realm.add(newSearch)
        }
    }
    
    func loadData(_ search: String) {
        let encodedString = search.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlHostAllowed)
        let urlString = "https://itunes.apple.com/search?term=\(encodedString!)&entity=album"
        let url = URL(string: urlString)
        guard url != nil else { return }
        let decoder = JSONDecoder()
        
        getJSON(url: url!) { data, error in
            
            if data != nil {
                let response = try? decoder.decode(Response.self, from: data!)
                
                if response == nil {
                    self.presenter?.showError()
                } else {
                    self.presenter?.updateAlbums(response!.results)
                }
            } else if error != nil {
                self.presenter?.showError()
            }
        }
    }
    
    private func getJSON(url: URL, completion: @escaping (Data?, Error?) -> Void) {

        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {

        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
}
