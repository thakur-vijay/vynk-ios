//
//  SwiftUIView.swift
//  VynkDatabaseKit
//
//  Created by Vijay Thakur on 27/06/26.
//

import GRDB

public typealias VynkFetchableRecord = FetchableRecord
public typealias VynkPersistableRecord = PersistableRecord
public typealias VynkTableRecord = TableRecord
public typealias VynkColumn = Column
public typealias VynkSQLExpression = SQLSpecificExpressible & Sendable
public typealias VynkDatabaseValueConvertible = DatabaseValueConvertible
public typealias VynkOrdering = SQLOrderingTerm & Sendable
public typealias VynkDatabaseCancellable = DatabaseCancellable
