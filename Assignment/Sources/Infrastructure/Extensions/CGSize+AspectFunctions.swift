//
// CGSize+AspectFunctions.swift
// Switchback
//
// Created by Igor Tarasenko
// Copyright (c) 2017 . All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

extension CGSize {

    static func aspectFit(aspectRatio: CGSize, boundingSize: CGSize) -> CGSize {

        let mW: CGFloat = boundingSize.width / aspectRatio.width
        let mH: CGFloat = boundingSize.height / aspectRatio.height

        var resultSize: CGSize = boundingSize

        if mH < mW {
            resultSize.width = boundingSize.height / aspectRatio.height * aspectRatio.width
        } else if mW < mH {
            resultSize.height = boundingSize.width / aspectRatio.width * aspectRatio.height
        }

        return resultSize
    }

    static func aspectFill(aspectRatio: CGSize, minimumSize: CGSize) -> CGSize {

        let mW: CGFloat = minimumSize.width / aspectRatio.width
        let mH: CGFloat = minimumSize.height / aspectRatio.height

        var resultSize: CGSize = minimumSize

        if mH > mW {
            resultSize.width = minimumSize.height / aspectRatio.height * aspectRatio.width
        } else if mW > mH {
            resultSize.height = minimumSize.width / aspectRatio.width * aspectRatio.height
        }

        return resultSize
    }

    func aspectFit(bounding size: CGSize) -> CGSize {

        return CGSize.aspectFit(aspectRatio: self, boundingSize: size)
    }

    func aspectFill(minimum size: CGSize) -> CGSize {

        return CGSize.aspectFill(aspectRatio: self, minimumSize: size)
    }
}
