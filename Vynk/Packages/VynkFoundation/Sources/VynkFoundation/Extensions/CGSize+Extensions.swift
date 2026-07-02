//
//  File.swift
//  VynkFoundation
//
//  Created by Vijay Thakur on 02/07/26.
//

import Foundation

public extension CGSize {

    func scaled(

        by scale: CGFloat

    ) -> CGSize {

        CGSize(

            width: width * scale,

            height: height * scale

        )

    }

}
