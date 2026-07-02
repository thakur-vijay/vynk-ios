//
//  Log.swift
//  VynkFoundation
//
//  Created by Vijay Thakur on 02/07/26.
//


import Foundation
import OSLog

public enum Log {

    private static let subsystem =
        Bundle.main.bundleIdentifier ?? "Vynk"

    // MARK: - Public

    public static func debug(
        _ items: Any...,
        category: LogCategory = .general,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        logger(for: category)
            .debug("\(formattedMessage(from: items, file: file, function: function, line: line))")
    }

    public static func info(
        _ items: Any...,
        category: LogCategory = .general,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        logger(for: category)
            .info("\(formattedMessage(from: items, file: file, function: function, line: line))")
    }

    public static func error(
        _ items: Any...,
        category: LogCategory = .general,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        logger(for: category)
            .error("\(formattedMessage(from: items, file: file, function: function, line: line))")
    }

    public static func fault(
        _ items: Any...,
        category: LogCategory = .general,
        file: String = #fileID,
        function: String = #function,
        line: Int = #line
    ) {
        logger(for: category)
            .fault("\(formattedMessage(from: items, file: file, function: function, line: line))")
    }

    // MARK: - Private

    private static func logger(
        for category: LogCategory
    ) -> Logger {
        Logger(
            subsystem: subsystem,
            category: category.rawValue
        )
    }

    private static func formattedMessage(
        from items: [Any],
        file: String,
        function: String,
        line: Int
    ) -> String {

        let fileName = URL(fileURLWithPath: file)
            .lastPathComponent

        let message = items
            .map { String(describing: $0) }
            .joined(separator: " ")

        return "[\(fileName):\(line)] \(function) - \(message)"
    }
}
