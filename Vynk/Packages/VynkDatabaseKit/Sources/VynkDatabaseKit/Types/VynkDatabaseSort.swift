//
//  VynkDatabaseSort.swift
//  VynkDatabaseKit
//
//  Created by Vijay Thakur on 27/06/26.
//

import Foundation


public enum VynkDatabaseSort: Sendable {

    case ascending(VynkColumnName)

    case descending(VynkColumnName)

}
