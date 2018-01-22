//
// UIImage.swift
// Created by Igor Tarasenko on 19/10/17.
// Copyright © 2017 Igor Tarasenko
// Licensed under the MIT license, see LICENSE file
//

import UIKit

extension UIImage {
    public func roundCorner(radius: CGFloat, resize finalSize: CGSize) -> UIImage? {
        let aspectSize = size.aspectFill(minimum: finalSize)
        let rect = CGRect(origin: .zero, size: aspectSize)

        UIGraphicsBeginImageContextWithOptions(aspectSize, false, UIScreen.main.scale)
        let maskPath = UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: .allCorners,
                cornerRadii: CGSize(width: radius, height: radius)
        )
        maskPath.addClip()
        draw(in: rect)
        let modifiedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return modifiedImage
    }

    public static func from(color: UIColor) -> UIImage? {
        let pixelScale = UIScreen.main.scale
        let pixelSize = 1 / pixelScale
        let fillSize = CGSize(width: pixelSize, height: pixelSize)
        let fillRect = CGRect(origin: CGPoint.zero, size: fillSize)

        UIGraphicsBeginImageContextWithOptions(fillRect.size, false, pixelScale)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color.cgColor)
        graphicsContext?.fill(fillRect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}
