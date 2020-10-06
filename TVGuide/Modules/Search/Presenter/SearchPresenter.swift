//
//  SearchPresenter.swift
//  TVGuide
//
//  Created by troquer on 10/5/20.
//  Copyright © 2020 troquer. All rights reserved.
//

import UIKit

struct SearchPresenter {
    let dataSource = SearchViewDataSource()
    
    mutating func search(for keyword: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        dataSource.search(request: keyword, completion: completion)
    }

}
