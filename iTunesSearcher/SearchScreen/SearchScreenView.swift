//
//  SearchScreenView.swift
//  iTunesSearcher
//
//  Created by Captain Kidd on 01.12.2021.
//

import Foundation
import UIKit

protocol SearchScreenViewControllerProtocol {
    var presenter: SearchScreenPresenterProtocol? { get set }
    
    func reloadCollection(_ albums: [Album])
    func displayError()
}

class SearchScreenViewController: UIViewController,
                                  SearchScreenViewControllerProtocol,
                                  UISearchBarDelegate,
                                  UICollectionViewDelegate,
                                  UICollectionViewDataSource {
    
    var presenter: SearchScreenPresenterProtocol?
    private let searchController = UISearchController()
    private var collectionView: UICollectionView?
    private var albums: [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        didLoadSetup()
        setCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame  = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !SearchFromHistory.sharedData.search.isEmpty {
            presenter?.getAlbums(SearchFromHistory.sharedData.search)
            SearchFromHistory.sharedData.search = ""
        }
    }
    
    private func didLoadSetup() {
        view.backgroundColor = .white
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: view.frame.size.width / 2 - 1,
                                 height: view.frame.size.height / 4)
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: CollectionViewCell.id)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.id,
                                                      for: indexPath) as! CollectionViewCell
        cell.set(data: albums[indexPath.row].artworkUrl100,
                 album: albums[indexPath.row].collectionName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Detail.sharedData.collectionId = albums[indexPath.row].collectionId
        Detail.sharedData.artistName = albums[indexPath.row].artistName
        Detail.sharedData.albumName = albums[indexPath.row].collectionName
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        Detail.sharedData.image = cell.image.image
        
        presenter?.openDetails()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        presenter?.getAlbums(text)
        presenter?.saveToHistory(text)
    }
    
    func reloadCollection(_ albums: [Album]) {
        self.albums = albums
        self.albums = self.albums.sorted { $0.collectionName < $1.collectionName }
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func displayError() {
        let alert = UIAlertController(title: "Error", message: "Smth went wrong with downloading", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
