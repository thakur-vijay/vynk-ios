//
//  CameraOutput.swift
//  Vynk
//
//  Created by Vijay Thakur on 08/06/26.
//

import UIKit
import Foundation

enum CameraOutput: Hashable{
    case photo(UIImage)
    case video(URL)
}
