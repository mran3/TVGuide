//
//  SearchVC+CollectionView.swift
//  TVGuide
//
//  Created by troquer on 10/5/20.
//  Copyright © 2020 troquer. All rights reserved.
//

import UIKit

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        let height = collectionView.bounds.size.height
        
        switch self.deviceState {
        case .phonePortrait:
            return CGSize(width: width, height: width)
        case .phoneLandscape:
            return CGSize(width: height, height: height)
        case .tablet:
            let columns: CGFloat = 4
            let padding: CGFloat = 16
            
            return CGSize(width: (width / columns) - padding, height: (width / columns) - padding)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tvShowToPass = self.presenter.dataSource.tvShows[indexPath.row]
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }
        
}
