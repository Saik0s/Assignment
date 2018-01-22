//
//  STAnimationView.swift
//  Allan Weir
//
//  Created by Allan Weir on 06/02/2017.
//  Copyright © 2017 Allan Weir. All rights reserved.
//  http://www.studiousdesigns.com
//

import UIKit
import Lottie

public class STAnimationView: LOTAnimationView {
    private var displayLink: CADisplayLink?
    private var lastUpdateTime: CGFloat = 0
    private var endTime: CGFloat = 1
    private var lastTimeStamp: Date = Date()
    private(set) var isPlayingReverse: Bool = false

    class func animation(named animationName: String) -> STAnimationView {
        let urlPath = Bundle.main.path(forResource: animationName, ofType: "json").require()
        return STAnimationView(contentsOf: URL(fileURLWithPath: urlPath))
    }

    func play(fromPosition: CGFloat, toPosition: CGFloat) {
        if let oldLink = self.displayLink {
            oldLink.invalidate()
        }

        displayLink = CADisplayLink(
                target: self,
                selector: #selector(STAnimationView.updateDisplayLink(link:))
        )
        displayLink?.add(to: RunLoop.main, forMode: .defaultRunLoopMode)

        isPlayingReverse = (toPosition < fromPosition)

        lastUpdateTime = fromPosition
        endTime = toPosition
        animationProgress = fromPosition
        lastTimeStamp = Date()
    }

    @objc
    internal func updateDisplayLink(link _: CADisplayLink) {

        let newTime = Date()
        let timePassed = newTime.timeIntervalSince(lastTimeStamp)
        let deltaProgress = CGFloat(timePassed) * (animationSpeed / animationDuration)
        var newProgress = !isPlayingReverse ? animationProgress + deltaProgress : animationProgress - deltaProgress

        if !isPlayingReverse {
            if newProgress >= endTime {
                newProgress = endTime
                displayLink?.invalidate()
                displayLink = nil
            }
        } else {
            if newProgress <= endTime {
                newProgress = endTime
                displayLink?.invalidate()
                displayLink = nil
            }
        }

        animationProgress = newProgress
        lastTimeStamp = newTime
    }
}
