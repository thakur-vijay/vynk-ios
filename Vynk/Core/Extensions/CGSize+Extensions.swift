//
//  CGSize+Extensions.swift
//  Vynk
//
//  Created by Vijay Thakur on 06/06/26.
//

import Foundation

extension CGSize {

    func scaled(

        by scale: CGFloat

    ) -> CGSize {

        CGSize(

            width: width * scale,

            height: height * scale

        )

    }

}
