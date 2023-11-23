//
//  ImageAnimationView.swift
//  Bank 316
//
//  Created by Smt MacMini 3 on 03/11/23.
//

import Foundation
import UIKit

class AnimationImageView: UIImageView {
    // MARK: Overrides
    static var action:(()->())?
    override func startAnimating() {
        guard let frames = animationImages, frames.count > 1 else {
            return
        }
        image = frames.first
        
        let timePerFrame = 1.0
        let timer = Timer(fire: Date(timeIntervalSinceNow: timePerFrame),
                          interval: timePerFrame,
                          repeats: true) { [weak self] _ in
            self?.changeFrame()
        }
        RunLoop.current.add(timer, forMode: .common)
        frameTimer = timer
    }
    
    override func stopAnimating() {
        frameTimer?.invalidate()
        frameTimer = nil
        currentFrameIndex = 0
    }
    
    // MARK: Private
    private var frameTimer: Timer?
    private var isAnimatingForward = true
    
    private var currentFrameIndex = 0 {
        didSet {
            if let frames = animationImages,
               currentFrameIndex >= 0,
               currentFrameIndex < frames.count {
                let newImage = frames[currentFrameIndex]
                if self.image != newImage {
                    UIView.transition(with: self, duration: 0.7, options: .transitionCrossDissolve, animations: {
                        self.image = newImage
                    }, completion: nil)
                }
            }
        }
    }
    
    private func changeFrame() {
        guard let frames = animationImages, frames.count > 1 else {
            stopAnimating()
            return
        }
        
        let canAnimateForward = currentFrameIndex < frames.count - 1
        var canAnimateBackward = currentFrameIndex > 0
        isAnimatingForward = (isAnimatingForward && canAnimateForward) || (!isAnimatingForward && !canAnimateBackward)
        currentFrameIndex += isAnimatingForward ? 1 : 0
        if !isAnimatingForward{
            guard let backAction = AnimationImageView.action else {return}
            backAction()
            stopAnimating()
        }
    }
}



//class ImagePopupContainerView: UIView {
//    var closeButton: UIButton!
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        // Add a less blurred background
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.alpha = 0.6 // Adjust alpha to control blurriness
//        blurEffectView.frame = self.bounds
//        self.addSubview(blurEffectView)
//
//
//        // Create a close button
//        closeButton = UIButton(type: .custom)
//        closeButton.setTitle("Close", for: .normal)
//        closeButton.frame = CGRect(x: 10, y: 30, width: 60, height: 30)
//        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
//        self.addSubview(closeButton)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    @objc func closeButtonTapped() {
//        removeFromSuperview()
//    }
//}
