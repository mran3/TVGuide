//
//  TVShow.swift
//  TVGuide
//
//  Created by troquer on 10/4/20.
//  Copyright © 2020 troquer. All rights reserved.
//

import Foundation

struct TVSearchResponse: Decodable {
    let show: TVShow?
}

struct TVShow: Decodable {
    let id: Int?
    let name: String
    let type: String?
    let language: String?
    let genres: [String]
    let status: String?
    let premiered: String?
    let summary: String?
    let rating: Rating?
    let image: ImageReference?
}

struct Rating: Decodable, Equatable {
    let average: Double?
}

struct ImageReference: Decodable, Equatable {
    private let medium: String
    private let original: String
    var mediumURL: URL? { return URL(string: medium) }
    var originalURL: URL? { return URL(string: original) }
}
