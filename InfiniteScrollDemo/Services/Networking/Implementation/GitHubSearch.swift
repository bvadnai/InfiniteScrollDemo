//
//  GitHubSearch.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import Foundation
import Moya

private let accessToken = "***REMOVED***"

enum GitHubSearch {
    case repositories(page: Int, perPage: Int)
}

extension GitHubSearch: TargetType {
    var baseURL: URL { return URL(string: "https://api.github.com/search")! }
    var path: String {
        switch self {
        case .repositories:
            return "/repositories"
        }
    }
    var method: Moya.Method {
        switch self {
        case .repositories:
            return .get
        }
    }
    var sampleData: Data { return "Sample data".data(using: String.Encoding.utf8)! }
    var task: Task {
        switch self {
        case .repositories(page: let page, perPage: let perPage):
            let params: [String: Any] = [
                ServerKey.page: page,
                ServerKey.perPage: perPage
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    var headers: [String: String]? { return nil }
}
