//
//  URL+Https.swift
//  TVGuide
//
//  Created by troquer on 10/5/20.
//  Copyright © 2020 troquer. All rights reserved.
//

import Foundation

extension URL {
    func toHttps() -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return self }
        components.scheme = "https"
        guard let httpsURL = components.url else { return self }
        return httpsURL
    }
}
