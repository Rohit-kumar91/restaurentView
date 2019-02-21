//
//  NetworkService.swift
//  ResturentViewApp
//
//  Created by Rohit Prajapati on 13/01/19.
//  Copyright © 2019 Rohit Prajapati. All rights reserved.
//

import Foundation
import Moya

private let apiKey = "fcBpKXbhtVEtrT7xmB6BchWYf10CUF3ba0DRoKrCYEyqKU7R1rwgIjx6Emln1dEGGLD6LGecsHyVoFdLfqal-9Sy1wWJHDVT5Wpa6CHoCfG1MvgodGglvvtfIFI7XHYx"

enum YelpService  {
    
    enum BusinessProvider: TargetType {
        
        case search(lat: Double, long: Double)
        case details(id: String)

        var baseURL: URL {
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }

        var path: String {
            switch self {
            case .search:
                return "/search"
            
            case let .details(id):
                return "/\(id)"
            }
        }
        
        var method: Moya.Method {
            return .get
        }
        
        var sampleData: Data {
            return Data()
        }
        
        var task: Task {
            switch self {
            case let .search(lat, long):
                return .requestParameters(
                    parameters: ["latitude": lat, "longitude": long, "limit": 10], encoding: URLEncoding.queryString)
            
            case .details:
                return .requestPlain
            
            }
        }
        
        var headers: [String : String]? {
            return ["Authorization" : "Bearer \(apiKey)"]
        }
    }
}
