//
//  GitHubSearch.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import Foundation
import Moya

// TODO: - Your private GitHub access token goes here.

private let accessToken = ***REMOVED***

enum GitHubSearch {
    case repositories(query: String, sort: String, order: String, page: Int, perPage: Int)
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
        var params = [String: Any]()
        params[ServerKey.accessToken] = accessToken
        switch self {
        case .repositories(query: let query, sort: let sort, order: let order, page: let page, perPage: let perPage):
            params[ServerKey.query] = query
            params[ServerKey.sort] = sort
            params[ServerKey.order] = order
            params[ServerKey.page] = page
            params[ServerKey.perPage] = perPage
        }

        return .requestParameters(parameters: params, encoding: CustomParameterEncoding.default)
    }
    var headers: [String: String]? { return nil }
}
