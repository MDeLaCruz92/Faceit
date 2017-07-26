//
//  BlinkingFaceViewController.swift
//  FaceIt2017
//
//  Created by Michael De La Cruz on 7/18/17.
//  Copyright © 2017 Michael De La Cruz. All rights reserved.
//

import UIKit

class BlinkingFaceViewController: FaceViewController
{
    var blinking = false {
        didSet {
            blinkIfNeeded()
        }
    }
    
    override func updateUI() {
        super.updateUI()
        blinking = expression.eyes == .squinting
    }
    
    private struct BlinkRate {
        static let closedDuration: TimeInterval = 0.4
        static let openDuration: TimeInterval = 2.5
    }
    
    private var canBlink = false
    private var inABlink = false
    
    private func blinkIfNeeded() {
        if blinking && canBlink && !inABlink {
            faceView.eyesOpen = false
            inABlink = true
            Timer.scheduledTimer(withTimeInterval: BlinkRate.closedDuration, repeats: false, block: { [weak self] timer in
                self?.faceView.eyesOpen = true
                Timer.scheduledTimer(withTimeInterval: BlinkRate.openDuration, repeats: false, block: { [weak self] (timer) in
                    self?.inABlink = false
                    self?.blinkIfNeeded()
                })
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        canBlink = true
        blinkIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        canBlink = false
    }
}
