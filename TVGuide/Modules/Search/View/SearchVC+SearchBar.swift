//
//  SearchVC+SearchBar.swift
//  AHTVmazeDemo
//
//  Created by troquer on 10/5/20.
//  Copyright © 2020 troquer. All rights reserved.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        presenter.search(for: keyword) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let shouldRefresh):
                if shouldRefresh {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Ups!", message: "Your search got lost in the forest. Try again later.", preferredStyle: .alert)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    func setupSearchBar() {
        searchBar.delegate = self
        
        let searchField = searchBar.value(forKey: "searchField") as? UITextField
        searchField?.textColor = .white
        
        let placeholderLabel = searchField?.value(forKey: "placeholderLabel") as? UILabel
        placeholderLabel?.textColor = .white
        
        let glassIconView = searchField?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = .white
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload), object: nil)
        self.perform(#selector(self.reload), with: nil, afterDelay: 0.5)
    }
        
    @objc func reload() {
        searchBarSearchButtonClicked(searchBar)
    }
    
    
}
