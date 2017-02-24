//
//  AngularOverlayView.swift
//  Angular Overlay
//
//  Created by Illya Starikov on 7/5/16.
//  Copyright © 2016 Illya Starikov. All rights reserved.
//

import UIKit

//protocol UIButtonDelegate {
//    var topButton: UIButton { get set }
//    var bottomButton: UIButton { get set }
//
//    func topButtonPress()
//    func bottomButtonPress()
//}

@IBDesignable
class AngularOverlay: UIView {
    public var topButton =  UIButton() {
        didSet {
//            topButton.setTitle("25:00", for: [])
            setDefaults(to: &topButton)
        }
    }
    
    public var bottomButton = UIButton() {
        didSet {
            bottomButton.setTitle("Start Timer", for: [])
            bottomButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchDown)
            setDefaults(to: &bottomButton)
        }
    }
    
    var bottomButtonAction: () -> Void = { return }
    
    @objc private func bottomButtonTapped() {
        bottomButtonAction()
    }
    
    
    private struct Ratios {
        static let topRightRatioToScreen: CGFloat = 10/35
        static let topLeftRatioToScreen: CGFloat = 1/12
        
        static let bottomRightRatioToScreen: CGFloat = 10/35
        static let bottomLeftRatioToScreen: CGFloat = 1/12
        
        static let bottomPaddingRatioToScreen: CGFloat = 1/12
        
        static let paddingToUILabel: CGFloat = 1/20
        
        static let labelPaddingX: CGFloat = 1/3
        static let labelPaddingY: CGFloat = 1/10
        
        static let fontRatio: CGFloat = 1/15
    }
    
    private struct Defaults {
        static let defaultFont = "Futura"
        static let defaultColor = UIColor.black
    }
    
    private enum Direction {
        case Up
        case Down
    }
    
    private func calculateHypotenuse(opposite a: Double, adjacent b: Double) -> Double {
        return sqrt(pow(a, 2) + pow(b, 2))
    }
    
    private func setDefaults(to button: inout UIButton) {
        let fontSize = Ratios.fontRatio * bounds.maxY
        button.titleLabel?.font = UIFont(name: Defaults.defaultFont, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        button.titleLabel?.textAlignment = .center
        
        button.setTitleColor(Defaults.defaultColor, for: [])
        button.titleLabel?.lineBreakMode = .byClipping
    }
    
    private func drawOpaqueBackground() {
        let boundsSize = CGSize(width: bounds.width, height: bounds.height)
        let boundsRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: boundsSize)
        
        let path = UIBezierPath(rect: boundsRect)
        path.fill(with: CGBlendMode.luminosity, alpha: 0.0)
        path.stroke()
    }
    
    private func pathForTopBound() -> UIBezierPath {
        let leftY = bounds.maxY * Ratios.topLeftRatioToScreen
        let rightY = bounds.maxY * Ratios.topRightRatioToScreen
        let leftMostPoint = CGPoint(x: 0.0, y: leftY)
        let rightMostPoint = CGPoint(x: bounds.maxX, y: rightY)
        
        let path = UIBezierPath()
        path.move(to: leftMostPoint)
        path.addLine(to: rightMostPoint)
        
        return path
    }
    
    private func pathForBottomBound() -> UIBezierPath {
        let padding = bounds.maxY * Ratios.bottomPaddingRatioToScreen
        
        let leftY =  bounds.maxY - bounds.maxY * Ratios.bottomLeftRatioToScreen - padding
        let rightY =  bounds.maxY - bounds.maxY * Ratios.bottomRightRatioToScreen - padding
        let leftMostPoint = CGPoint(x: bounds.maxX, y: leftY)
        let rightMostPoint = CGPoint(x: 0.0, y: rightY)
        
        let path = UIBezierPath()
        path.move(to: leftMostPoint)
        path.addLine(to: rightMostPoint)
        
        return path
    }
    
    private func add(button: inout UIButton, to line: UIBezierPath, directed direction: Direction) {
        let centerY, leftY, rightY: CGFloat
        var angle: Double
        let frame: CGRect
        
        switch direction {
        case .Up:
            leftY = bounds.maxY * Ratios.topLeftRatioToScreen
            rightY = bounds.maxY * Ratios.topRightRatioToScreen
            
        case .Down:
            let padding = bounds.maxY * Ratios.bottomPaddingRatioToScreen
            leftY =  bounds.maxY - bounds.maxY * Ratios.bottomLeftRatioToScreen - padding
            rightY =  bounds.maxY - bounds.maxY * Ratios.bottomRightRatioToScreen - padding
        }
        
        let opposite = Double(abs(rightY - leftY))
        let adjacent = Double(bounds.maxX)
        let hypotenuse = calculateHypotenuse(opposite: opposite, adjacent: adjacent)
        
        centerY = direction == .Up ? rightY - CGFloat(opposite * 0.85) : leftY - CGFloat(opposite * 0.50) // LeftY or rightY might be different heights depending on top or obttom view
        frame = CGRect(x: 0.0, y: centerY, width: CGFloat(bounds.maxX), height: Ratios.fontRatio * bounds.maxY)
        button = UIButton(frame: frame) // Reassign with proper frame (init can't be called with bounds)
        
        angle = asin(opposite/hypotenuse) // Use basic law of sines to calculate what how should be rotated
        button.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
    }
    
    private func finishPathToRestOfScreen(to line: UIBezierPath, directed direction: Direction) -> UIBezierPath {
        let path = line
        
        switch direction {
        case .Up:
            let topLeft = CGPoint(x: 0.0, y: 0.0)
            let topRight = CGPoint(x: bounds.maxX, y: 0.0)
            
            path.addLine(to: topRight)
            path.addLine(to: topLeft)
            
        case .Down:
            let bottomLeft = CGPoint(x: 0.0, y: bounds.maxY)
            let bottomRight = CGPoint(x: bounds.maxX, y: bounds.maxY)
            
            path.addLine(to: bottomLeft)
            path.addLine(to: bottomRight)
        }
        
        path.close()
        path.fill()
        
        return path
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.white.set()
        
        let topPath = pathForTopBound()
        let bottomPath = pathForBottomBound()
        
        add(button: &topButton, to: topPath, directed: .Up)
        add(button: &bottomButton, to: bottomPath, directed: .Down)
        
        finishPathToRestOfScreen(to: topPath, directed: .Up).stroke()
        finishPathToRestOfScreen(to: bottomPath, directed: .Down).stroke()
        
        self.addSubview(topButton)
        self.addSubview(bottomButton)
    }
}
