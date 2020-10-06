//
//  TVMazeTarget.swift
//  TVGuide
//
//  Created by troquer on 10/4/20.
//  Copyright © 2020 troquer. All rights reserved.
//

import Foundation
import Moya

enum TVMazeTarget: TargetType {
    
    case search(query: String)
    case series
    
    var path: String {
        switch self {
            case .search:
                return "/search/shows"
        default:
                return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .search:
                return .get
        default:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
      }
    
    // 5
    public var task: Task {
        switch self {
        case .search (let query):
            return .requestParameters(
                parameters: ["q": query],
                encoding: URLEncoding.default)
        default:
            return .requestPlain // TODO
        }
        
        
       
    }
    
    // 6
     public var headers: [String: String]? {
       return ["Content-Type": "application/json"]
     }
    
    public var baseURL: URL {
        return URL(string: "https://api.tvmaze.com")!
      }
}
