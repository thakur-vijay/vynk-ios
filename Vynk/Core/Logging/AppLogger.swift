//
//  AppLogger.swift
//  Vynk
//
//  Created by Vijay Thakur on 26/05/26.
//


import OSLog

enum AppLogger {

    private static let subsystem = Bundle.main.bundleIdentifier ?? "Vynk"

    static func debug(
        _ message: Any,
        tag: String = "General"
    ) {
        let logger = Logger(
            subsystem: subsystem,
            category: tag
        )

        logger.debug("\(String(describing: message))")
    }

    static func info(
        _ message: Any,
        tag: String = "General"
    ) {
        let logger = Logger(
            subsystem: subsystem,
            category: tag
        )

        logger.info("\(String(describing: message))")
    }

    static func error(
        _ message: Any,
        tag: String = "General"
    ) {
        let logger = Logger(
            subsystem: subsystem,
            category: tag
        )

        logger.error("\(String(describing: message))")
    }

    static func fault(
        _ message: Any,
        tag: String = "General"
    ) {
        let logger = Logger(
            subsystem: subsystem,
            category: tag
        )

        logger.fault("\(String(describing: message))")
    }
}