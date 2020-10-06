//
//  RemoteImage.swift
//  TVGuide
//
//  Created by troquer on 10/6/20.
//  Copyright © 2020 troquer. All rights reserved.
//

import UIKit

class RemoteImage {
    var imageCache = NSCache<NSString, UIImage>()
    
    let imageQueue = DispatchQueue(label: "net.zourz.TVGuide.downloadImgThread",
                                   qos: .background,
                                   attributes: .concurrent,
                                   autoreleaseFrequency: .workItem,
                                   target: nil)

    public func downloadImage(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> ()) {
        let url = url.toHttps()

        if let image = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(.success(image))
        } else {
            imageQueue.async {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    if error != nil {
                        completion(.failure(error!))
                        return
                    }
                    guard let data = data, let image = UIImage(data: data) else {
                        completion(.failure(error!))
                        return
                    }
                    completion(.success(image))
                }).resume()
            }
        }
    }
}
