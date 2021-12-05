//
//  DetailScreenView.swift
//  iTunesSearcher
//
//  Created by Captain Kidd on 01.12.2021.
//

import Foundation
import UIKit

protocol DetailScreenViewControllerProtocol {
    var presenter: DetailScreenPresenterProtocol? { get set }
    
    func updateCollection(_ tracks: [String])
    func displayError()
}

class DetailScreenViewController: UIViewController, DetailScreenViewControllerProtocol {
    
    var presenter: DetailScreenPresenterProtocol?
    var collectionView: UICollectionView! = nil
    
    var tracks: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        presenter?.loadDetails()
        setLayout()
    }
    
    func updateCollection(_ tracks: [String]) {
        self.tracks = tracks
        collectionView.reloadData()
    }
    
    private func setLayout() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.register(ListCell.self,
                                forCellWithReuseIdentifier: ListCell.reusableIdentifier)
        collectionView.register(HeaderView.self,
                                forSupplementaryViewOfKind: "header-element-kind",
                                withReuseIdentifier: HeaderView.reusableIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        //List layout
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        //Header layout
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(300))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: "header-element-kind",
                                                                        alignment: .top)

        section.boundarySupplementaryItems = [sectionHeader]
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func displayError() {
        let alert = UIAlertController(title: "Error", message: "Cant download/display songlist", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension DetailScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.reusableIdentifier, for: indexPath) as! ListCell
        
        cell.songName.text = tracks[indexPath.item]
        cell.backgroundColor = UIColor(red: 0.9,
                                       green: 0.9,
                                       blue: 0.9,
                                       alpha: 1.0)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: "header-element-kind", withReuseIdentifier: HeaderView.reusableIdentifier, for: indexPath) as! HeaderView

        cell.album.text = Detail.sharedData.albumName
        cell.artist.text = Detail.sharedData.artistName
        cell.imageView.image = Detail.sharedData.image

        return cell
    }
}
