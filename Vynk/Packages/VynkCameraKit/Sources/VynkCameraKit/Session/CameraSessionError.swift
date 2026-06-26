//
//  CameraSessionError.swift
//  Vynk
//
//  Created by Vijay Thakur on 25/06/26.
//

public enum CameraSessionError: Error {
    case cameraUnavailable
    case unableToAddInput
    case unableToAddOutput
    case captureInProgress
    
}
