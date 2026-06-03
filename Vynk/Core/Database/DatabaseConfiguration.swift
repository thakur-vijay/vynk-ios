//
//  DatabaseConfiguration.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import Foundation

struct DatabaseConfiguration {

    let filename: String

    static let live = DatabaseConfiguration(

        filename: "vynk.sqlite"

    )

}
