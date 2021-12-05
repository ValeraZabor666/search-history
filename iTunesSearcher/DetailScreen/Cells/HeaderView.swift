//
//  HeaderView.swift
//  iTunesSearcher
//
//  Created by Captain Kidd on 03.12.2021.
//

import Foundation
import UIKit

class HeaderView: UICollectionReusableView {
    
    static let reusableIdentifier = "header"
    
    var imageView = UIImageView()
    var artist = UILabel()
    var album = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setLayout() {
        addSubview(imageView)
        addSubview(artist)
        addSubview(album)
        
        album.textAlignment = .center
        artist.textAlignment = .center
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        artist.translatesAutoresizingMaskIntoConstraints = false
        album.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            artist.centerXAnchor.constraint(equalTo: centerXAnchor),
            artist.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            artist.widthAnchor.constraint(equalToConstant: self.frame.width),
            artist.heightAnchor.constraint(equalToConstant: 50),
            album.centerXAnchor.constraint(equalTo: centerXAnchor),
            album.topAnchor.constraint(equalTo: artist.bottomAnchor),
            album.widthAnchor.constraint(equalToConstant: self.frame.width),
            album.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 300)
    }
}
