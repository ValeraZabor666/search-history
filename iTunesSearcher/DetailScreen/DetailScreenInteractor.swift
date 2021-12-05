//
//  DetailScreenInteractor.swift
//  iTunesSearcher
//
//  Created by Captain Kidd on 01.12.2021.
//

import Foundation

protocol DetailScreenInteractorProtocol {
    var presenter: DetailScreenPresenterProtocol? { get set }
    
    func loadData()

}

class DetailScreenInteractor: DetailScreenInteractorProtocol {
    
    var presenter: DetailScreenPresenterProtocol?
    
    
    func loadData() {
        let collectionId = String(Detail.sharedData.collectionId)
        let urlString = "https://itunes.apple.com/lookup?id=\(collectionId)&entity=song"
        let url = URL(string: urlString)
        guard url != nil else { return }
        let decoder = JSONDecoder()
        
        getJSON(url: url!) { data, error in
            
            if data != nil {
                let response = try? decoder.decode(DetailResponse.self, from: data!)
                
                if response == nil {
                    self.presenter?.showError()
                } else {
                    var tracks: [String] = []
                    for res in response!.results {
                        if res.trackName != nil {
                            tracks.append(res.trackName!)
                        }
                    }
                    self.presenter?.updateDetails(tracks)
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
