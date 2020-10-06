//
//  SearchViewDataSource.swift
//  TVGuide
//
//  Created by troquer on 10/4/20.
//  Copyright © 2020 troquer. All rights reserved.
//

import UIKit
import Moya

class SearchViewDataSource: NSObject, UICollectionViewDataSource {
    
    var tvShows = [TVShow]()
    var imageCache = NSCache<NSString, UIImage>()
    
    func search(request: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        let provider = MoyaProvider<TVMazeTarget>()
        
        provider.request(.search(query: request)) { [weak self] result in
          guard let self = self else { return }

          // 3
          switch result {
          case .success(let response):
            do {
              // 4
              //print(try response.mapJSON())
                let receivedPosts = try response.map([TVSearchResponse].self)
                let filteredResponse = receivedPosts.filter({
                    if $0.show != nil {
                        return true
                    }
                    return false
                })
                self.tvShows = filteredResponse.map({$0.show!})
                
                completion(.success(!self.tvShows.isEmpty))
            } catch {
                print("Unexpected error: \(error).")
            }
            
          case .failure:
            print("failed network")
          }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShows.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowCell", for: indexPath)
        guard let tvShowCell = cell as? TVShowCell else { return cell }
        DispatchQueue.main.async {
            tvShowCell.loader.isHidden = false
            tvShowCell.loader.startAnimating()
        }
        configure(cell: tvShowCell, atIndexPath: indexPath)
        return tvShowCell
    }
    
    func configure(cell: TVShowCell, atIndexPath indexPath: IndexPath) {
        guard tvShows.indices.contains(indexPath.row) else { return }
        let tvShow = tvShows[indexPath.row]
        cell.title.text = tvShow.name
        guard let image = tvShow.image?.mediumURL else {
            cell.updateWith(nil)
            return
        }
        let imageManager = RemoteImage()
        imageManager.downloadImage(image) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(_):
                    cell.updateWith(nil)
                case .success(let image):
                    UIView.animate(withDuration: 0.5, animations: {
                        cell.updateWith(image)
                    })
                }
            }
        }
    }
}
