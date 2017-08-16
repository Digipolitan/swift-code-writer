//
//  PropertyWriter.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 16/08/2017.
//

import Foundation
import CodeWriter

public class PropertyWriter: CodeWriter {

    public typealias Description = PropertyDescription

    public static let `default` = PropertyWriter()

    private init() {}

    public func write(description: PropertyDescription, depth: Int) -> String {
        return ""
    }
}


