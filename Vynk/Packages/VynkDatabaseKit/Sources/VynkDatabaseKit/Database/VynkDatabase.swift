// The Swift Programming Language
// https://docs.swift.org/swift-book

import GRDB

public struct VynkDatabase {
    let db: Database

    init(db: Database) {
        self.db = db
    }
}

