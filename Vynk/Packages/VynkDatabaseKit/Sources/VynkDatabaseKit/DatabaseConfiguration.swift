//
//  DatabaseConfiguration.swift
//  Vynk
//
//  Created by Vijay Thakur on 03/06/26.
//

import Foundation

public struct DatabaseConfiguration : Sendable{

    let filename: String

    public static let live = DatabaseConfiguration(

        filename: "vynk.sqlite"

    )

}
