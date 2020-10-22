//
//  Logger.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import Foundation

enum LogEvent: String {
    case info = "[ℹ️]"
    case todo = "[💪]"
    case networking = "[📡]"
    case debug = "[🐛]"
    case warning = "[⚠️]"
    case error = "[‼]"
    case fatalError = "[🤷🏼‍♂️]"
    case severe = "[🔥]"
}

/// Provide informative log to console. Default event is `debug`.
func logger(_ messageElements: Any...,
            fileName: String = #file,
            line: Int = #line,
            funcName: String = #function,
            event: LogEvent = .debug) {
    #if DEBUG
    let pathComponents = fileName.components(separatedBy: "/")
    let extractedFileName = pathComponents.isEmpty ? "" : pathComponents.last!
    let message = messageElements.map { "\($0)" }.joined(separator: " ")
    print("<\(event.rawValue)> - \(message) - at line \(line) in \(funcName),\(extractedFileName)")
    #endif
}
