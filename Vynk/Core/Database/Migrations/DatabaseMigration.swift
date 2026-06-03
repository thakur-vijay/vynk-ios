//
//  DatabaseMigration.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import GRDB

protocol DatabaseMigration: Sendable{

    nonisolated var identifier: String { get }

    nonisolated func migrate(_ db: Database) throws

}
