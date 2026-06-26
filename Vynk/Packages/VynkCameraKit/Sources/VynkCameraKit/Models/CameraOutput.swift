//
//  CameraOutput.swift
//  VynkCameraKit
//
//  Created by Vijay Thakur on 26/06/26.
//

import UIKit

public enum CameraOutput: Hashable{
    case photo(UIImage)
    case video(URL)
}
