//
//  CollectionViewCell.swift
//  iTunesSearcher
//
//  Created by Captain Kidd on 02.12.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let id = "PhotoCell"
    
    var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        imageView.image = UIImage(named: "loadingImage")
        return imageView
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.text = nil
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
        image.frame = contentView.frame
        
        contentView.addSubview(label)
        label.frame = CGRect(x: 0, y: contentView.frame.height / 3,
                             width: contentView.frame.width, height: 35)
        label.layer.zPosition = .infinity
        label.backgroundColor = UIColor(white: 1, alpha: 0.5)
        label.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(data: String, album: String) {
        let url = URL(string: data)
        label.text = album
        image.layer.cornerRadius = 1
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        let imageURL: URL = url!
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: imageURL)) {
            image.image = UIImage(data: cachedResponse.data)
            return
        }
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            let dataTask = URLSession.shared.dataTask(with: imageURL) { [weak self] data,response,error in
                if let data = data, let response = response {
                    DispatchQueue.main.async {
                        self!.image.image = UIImage(data: data)!
                        self?.imageToCache(data: data, response: response)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    private func imageToCache(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
