//
//  ListCell.swift
//  iTunesSearcher
//
//  Created by Captain Kidd on 03.12.2021.
//

import Foundation
import UIKit

class ListCell: UICollectionViewCell {
    
    static let reusableIdentifier = "cell"
    var songName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setLayout() {
        songName.translatesAutoresizingMaskIntoConstraints = false
        songName.adjustsFontForContentSizeCategory = true
        songName.font = UIFont.preferredFont(forTextStyle: .body)
        songName.textColor = .label
        songName.adjustsFontSizeToFitWidth = true
        
        contentView.addSubview(songName)
        
        NSLayoutConstraint.activate([
            songName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            songName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            songName.widthAnchor.constraint(equalToConstant: contentView.frame.width - 10),
            songName.heightAnchor.constraint(equalToConstant: contentView.frame.height - 10),
            songName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
