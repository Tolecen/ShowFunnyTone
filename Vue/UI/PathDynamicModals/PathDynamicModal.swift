//
//  PathDynamicModal.swift
//  PathDynamicModal-Demo
//
//  Created by Ryo Aoyama on 2/9/15.
//  Copyright (c) 2015 Ryo Aoyama. All rights reserved.
//

import UIKit

@objc class PathDynamicModal: NSObject, UIGestureRecognizerDelegate {
    
    /* internal properties */
    
    var backgroundColor: UIColor = UIColor.black {
        didSet {
            self.backgroundView.backgroundColor = backgroundColor.withAlphaComponent(self.backgroundAlpha)
        }
    }
    var backgroundAlpha: CGFloat = 0.7 {
        didSet {
            self.backgroundView.backgroundColor = self.backgroundColor.withAlphaComponent(backgroundAlpha)
        }
    }
    var showMagnitude: CGFloat = 250.0
    var closeMagnitude: CGFloat = 170.0
    var closeByTapBackground: Bool = true
    var closeBySwipeBackground: Bool = true
    var showedHandler: (() -> Void)?
    var closedHandler: (() -> Void)?
    
    /* private properties */
    
    fileprivate weak var view: UIView!
    fileprivate var contentView: UIView! = UIView()
    fileprivate var backgroundView: ModalRetainView! = ModalRetainView()
    fileprivate var animator: UIDynamicAnimator!
    fileprivate var push: UIPushBehavior?
    fileprivate var tap: UITapGestureRecognizer!
    fileprivate var pan: UIPanGestureRecognizer!
    fileprivate var originalTranslatesAutoresizingMaskIntoConstraints: Bool! = true
    fileprivate var originalCenter: CGPoint! = CGPoint.zero
    
    /* internal functions */
    
    class func show(modalView view: UIView, inView: UIView) -> PathDynamicModal {
        let modal = PathDynamicModal()
        modal.show(modalView: view, inView: inView)
        
        return modal
    }
    
    func show(modalView view: UIView, inView: UIView) {
        self.view = view
        self.backgroundView.modal = self
        
        self.backgroundView.center = inView.center
        self.configureContentView(view: view)
        inView.addSubview(self.backgroundView)
        
        self.fadeBackgroundView(fromAlpha: 0, toAlpha: 1.0, completion: nil)
        self.applyShowBehaviors()
    }
    
    func closeWithLeansLeft() {
        self.close(horizontalOffset: -2.0)
    }
    
    func closeWithLeansRight() {
        self.close(horizontalOffset: 2.0)
    }
    
    func closeWithStraight() {
        self.close(horizontalOffset: 0)
    }
    
    func closeWithLeansRandom() {
        let rand = (30.0 - CGFloat(arc4random_uniform(60))) / 10.0
        self.close(horizontalOffset: rand)
    }
    
    override init() {
        super.init()
        self.setup()
    }
    
    /* private functions */
    
    fileprivate func setup() {
        self.animator = UIDynamicAnimator(referenceView: self.backgroundView)
        
        self.tap = UITapGestureRecognizer(target: self, action: #selector(PathDynamicModal.handleBackgroundView(_:)))
        self.tap.delegate = self
        
        self.pan = UIPanGestureRecognizer(target: self, action: #selector(PathDynamicModal.panBackgroundView(_:)))
        
        self.backgroundView.frame = UIScreen.main.bounds
        self.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        self.backgroundView.addGestureRecognizer(self.tap)
        self.backgroundView.addGestureRecognizer(self.pan)
    }
    
    fileprivate func close(horizontalOffset h: CGFloat) {
        self.applyCloseBehaviors(horizontalOffset: h)
        
        self.fadeBackgroundView(fromAlpha: 1.0, toAlpha: 0, completion: { (flag) -> () in
            self.backgroundView.removeFromSuperview()
            self.backgroundView.modal = nil
            
            self.view.center = self.originalCenter
            self.view.translatesAutoresizingMaskIntoConstraints = self.originalTranslatesAutoresizingMaskIntoConstraints
            
            self.closedHandler?()
            }
        )
    }
    
    fileprivate func applyShowBehaviors() {
        self.animator.removeAllBehaviors()
        
        self.push = UIPushBehavior(items: [self.contentView], mode: .instantaneous)
        self.push!.setTargetOffsetFromCenter(UIOffset(horizontal: -1.0, vertical: 0), for: self.contentView)
        self.push!.pushDirection = CGVector(dx: 0, dy: 1.0)
        self.push!.magnitude = self.showMagnitude
        self.push!.action = {[weak self] in
            if let sSelf = self {
                if sSelf.contentView.center.y >= sSelf.backgroundView.center.y - 30.0 {
                    sSelf.fixOnCenter()
                }
            }
        }
        
        self.animator.addBehavior(self.push!)
    }
    
    fileprivate func applyCloseBehaviors(horizontalOffset h: CGFloat) {
        self.animator.removeAllBehaviors()
        
        self.push = UIPushBehavior(items: [self.contentView], mode: .instantaneous)
        self.push!.setTargetOffsetFromCenter(UIOffset(horizontal: h, vertical: 0), for: self.contentView)
        self.push!.pushDirection = CGVector(dx: 0, dy: 1.0)
        self.push!.magnitude = self.closeMagnitude
        
        self.animator.addBehavior(self.push!)
    }
    
    fileprivate func fixOnCenter() {
        self.animator.removeAllBehaviors()
        
        UIView.animate(withDuration: 0.08, delay: 0, options: .beginFromCurrentState, animations: { () -> Void in
            self.contentView.center.y = self.backgroundView.center.y + 15.0
            self.contentView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 90.0))
            }, completion: { (flag) -> Void in
                UIView.animate(withDuration: 0.12, delay: 0, options: .beginFromCurrentState, animations: { () -> Void in
                    self.contentView.center = self.backgroundView.center
                    self.contentView.transform = CGAffineTransform.identity
                    }, completion:  { (flag) -> Void in
                        self.showedHandler?()
                        return
                })
        })
    }
    
    fileprivate func configureContentView(view: UIView) {
        self.originalCenter = view.center
        self.originalTranslatesAutoresizingMaskIntoConstraints = view.translatesAutoresizingMaskIntoConstraints
        view.translatesAutoresizingMaskIntoConstraints = true
        
        self.contentView.frame = view.bounds
        self.contentView.center = self.backgroundView.center
        self.contentView.frame.origin.y = -self.contentView.bounds.height
        view.frame.origin = CGPoint.zero
        
        self.contentView.addSubview(view)
        self.backgroundView.addSubview(self.contentView)
    }
    
    fileprivate func fadeBackgroundView(fromAlpha: CGFloat, toAlpha: CGFloat, completion: ((Bool) -> ())?) {
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .beginFromCurrentState, animations: { () -> Void in
            self.backgroundView.backgroundColor = self.backgroundColor.withAlphaComponent(self.backgroundAlpha * fromAlpha)
            self.backgroundView.backgroundColor = self.backgroundColor.withAlphaComponent(self.backgroundAlpha * toAlpha)
        }) { (flag) -> Void in
            completion?(flag)
            return
        }
    }
    
    fileprivate func tapPointXPercentage(pointX: CGFloat) -> CGFloat {
        /* return |-1 0 1| */
        let width = self.backgroundView.bounds.width
        if pointX >= width / 2.0 {
            return (2.0 - width / pointX)
        }else {
            return -(2.0 - width / (width - (pointX + 1)))
        }
    }
    
    func handleBackgroundView(_ sender: UITapGestureRecognizer) {
        if self.closeByTapBackground {
            let locationX = sender.location(in: self.backgroundView).x
            let offsetH: CGFloat = 3.0 * self.tapPointXPercentage(pointX: locationX)
            self.close(horizontalOffset: offsetH)
        }
    }
    
    func panBackgroundView(_ sender: UIPanGestureRecognizer) {
        if self.closeBySwipeBackground {
            let location = sender.location(in: self.backgroundView)
            let pan = sender.translation(in: self.backgroundView)
            let velocityY = sender.velocity(in: self.backgroundView).y
            
            let isDownGesuture = self.contentView.center.y >= self.backgroundView.center.y
            let panYAmountOnBackground = pan.y / self.backgroundView.bounds.height
            let angle = (CGFloat(M_PI) / 180.0) * self.tapPointXPercentage(pointX: location.x) * (8.0 * panYAmountOnBackground)
            
            switch sender.state {
            case .changed:
                self.contentView.transform = CGAffineTransform(rotationAngle: isDownGesuture ? angle : 0)
                self.contentView.center.y = self.backgroundView.center.y + (isDownGesuture ? pan.y : pan.y / 10.0)
                self.backgroundView.backgroundColor = self.backgroundColor.withAlphaComponent(self.backgroundAlpha * (isDownGesuture ? 1.0 - panYAmountOnBackground : 1.0))
            case .cancelled, .ended:
                if self.contentView.center.y >= self.backgroundView.bounds.height
                    || velocityY >= 200.0 {
                    self.close(horizontalOffset: 0)
                }else {
                    UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState, .curveEaseOut], animations: { () -> Void in
                        self.contentView.transform = CGAffineTransform.identity
                        self.contentView.center = self.backgroundView.center
                        self.backgroundView.backgroundColor = self.backgroundColor.withAlphaComponent(self.backgroundAlpha)
                        }, completion: nil)
                }
            default:
                break
            }
        }
    }
    
    /* delegate functions */
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return gestureRecognizer.view == touch.view ? true : false
    }
}

private class ModalRetainView: UIView {
    fileprivate var modal: PathDynamicModal?
}
