//
//  Application.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import UIKit
import Swinject

let sharedApplication: Application = UIApplication.shared as! Application

final class Application: UIApplication {
    // MARK: - Properties

    let assembler: Assembler

    private(set) lazy var coordinator: SceneCoordinatorProtocol = assembler.resolver.resolve(SceneCoordinatorProtocol.self)!

    // MARK: - Initialization

    override init() {
        let assemblies: [Assembly] = [
            ScenesAssemblyContainer(),
            ServicesAssemblyContainer(),
            ViewModelsAssemblyContainer()
        ]
        assembler = Assembler(assemblies)

        super.init()
    }
}
