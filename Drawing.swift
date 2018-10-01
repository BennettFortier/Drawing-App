//
//  Drawing.swift
//  BenFortier-Lab3
//
//  Created by Rena fortier on 9/27/18.
//  Copyright © 2018 Ben Fortier. All rights reserved.
//

import UIKit

class Drawing: UIView {
    var circleArray: Circle? {
        didSet {
            setNeedsDisplay()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    //Drawing function
    override func draw(_ rect: CGRect) {
        let color: UIColor = (circleArray?.color)!
        let thick = (circleArray?.thickness)!
        let path = createQuadPath(points: circleArray!.points)
        let r = thick/2
        color.setStroke()
        color.setFill()
        path.lineWidth = thick
        path.stroke(with: .normal, alpha: 1)
        createCircle(center: circleArray!.points[0], radius: r)
        createCircle(center: circleArray!.points[(circleArray!.points.count)-1], radius: r)

    }
    
    //Creates a circle at the center/radius given.
    func createCircle(center: CGPoint, radius: CGFloat)  {
        let path = UIBezierPath()
        path.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
        path.fill()
    }
    
    
    //Functions we were given
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        let x = (first.x + second.x)/2
        let y = (first.y + second.y)/2
        return CGPoint(x: x, y: y)
    }
    
    func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        if points.count < 2 { return path }
        let firstPoint = points[0]
        let secondPoint = points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        path.addLine(to: firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentPoint = points[index]
            let nextPoint = points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
        }
        guard let lastLocation = points.last else { return path }
        path.addLine(to: lastLocation)
        return path
    }
    
  

}
