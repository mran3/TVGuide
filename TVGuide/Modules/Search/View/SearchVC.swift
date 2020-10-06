//
//  ViewController.swift
//  TVGuide
//
//  Created by troquer on 10/4/20.
//  Copyright © 2020 troquer. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presenter = SearchPresenter()
    
    var tvShowToPass: TVShow? = nil
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        return layout
    }()
    
    var deviceState: DeviceState {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return UIApplication.shared.statusBarOrientation.isLandscape ? .phoneLandscape : .phonePortrait
        case .pad:
            return .tablet
        default:
            return .phonePortrait
        }
    }
    
    var scrollDirection: UICollectionView.ScrollDirection {
        switch deviceState {
        case .phonePortrait:
            return .vertical
        case .phoneLandscape:
            return .horizontal
        case .tablet:
            return .vertical
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = presenter.dataSource
        collectionView.delegate = self
        configGradient()
        setupSearchBar()
    }

    
    func configGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [#colorLiteral(red: 0.2352941176, green: 0.5803921569, blue: 0.5450980392, alpha: 1).cgColor,#colorLiteral(red: 0.1176470588, green: 0.2823529412, blue: 0.2666666667, alpha: 1).cgColor]
        self.view.layer.insertSublayer(gradient, at: 0)
        
    }
        
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { _ in
            self.layout.scrollDirection = self.scrollDirection
            self.layout.invalidateLayout()
            self.view.layoutIfNeeded()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let controller = segue.destination as! DetailVC
            controller.tvShow = tvShowToPass
        }
    }
    
}
