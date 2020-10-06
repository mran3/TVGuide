//
//  DetailVC.swift
//  TVGuide
//
//  Created by troquer on 10/5/20.
//  Copyright © 2020 troquer. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    var tvShow: TVShow? = nil
    
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    
    override func viewDidLoad() {
        setupInfo()
    }
    
    func setupInfo(){
        if let tvShow = self.tvShow {
            nameLbl.text = tvShow.name
            summaryLbl.attributedText = tvShow.summary?.htmlToAttributedString
            genreLbl.text = tvShow.genres.joined(separator: ", ")
            
            
            guard let image = tvShow.image?.mediumURL else {
                return
            }
            let imageManager = RemoteImage()
            imageManager.downloadImage(image) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(_):
                        return
                    case .success(let image):
                        self.showImage.image = image
                    }
                }
            }
            
        }
    }
}
