//
//  TVShowCell.swift
//  TVGuide
//
//  Created by troquer on 10/5/20.
//  Copyright © 2020 troquer. All rights reserved.
//

import UIKit

class TVShowCell: UICollectionViewCell {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        updateWith(nil)
        title.text = ""
    }

    func updateWith(_ image: UIImage?) {
        DispatchQueue.main.async {
            if let image = image {
                self.image.image = image
            } else {
                self.image.image = nil
            }
            self.loader.stopAnimating()
        }
    }
}
