//
//  ServicesAssemblyContainer.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import Foundation
import Swinject
import Moya

final class ServicesAssemblyContainer: Assembly {
    func assemble(container: Container) {
        container.register(ReachabilityType.self) { _ in DefaultReachability() }
        container.register(MoyaProvider<GitHubSearch>.self) { _ in
            return MoyaProvider<GitHubSearch>(callbackQueue: DispatchQueue.global(qos: .utility))
        }
        container.register(MoyaEndpoint.self) { resolver in
            MoyaEndpoint(
                provider: resolver.resolve(MoyaProvider<GitHubSearch>.self)!,
                reachability: resolver.resolve(ReachabilityType.self)!
            )
        }
        container.register(RepositoriesServiceProtocol.self) { resolver in resolver.resolve(MoyaEndpoint.self)! }
    }
}
