//
//  ModuleDependency.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 17/08/2017.
//

import Foundation

public protocol ModuleDependency {

    func moduleDependencies() -> [String]
}

public extension ModuleDependency {
    
    public static func union(modules: [String], with dependencies: [ModuleDependency]) -> [String] {
        var res = Set<String>(modules)
        dependencies.forEach { res.formUnion($0.moduleDependencies()) }
        return Array(res)
    }
}
