//
//  DrawingBoard.swift
//  BenFortier-Lab3
//
//  Created by Rena fortier on 9/27/18.
//  Copyright © 2018 Ben Fortier. All rights reserved.
//

import UIKit

class DrawingBoard: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.white
    }
    var drawing: Drawing?
    private func append(point: CGPoint){
        drawing!.circleArray?.points.append(point)

    }
    //Upon touch begin, start a new drawing, append the point to the points of the drawing's circleArray. Add the drawing to the subview
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: self) as CGPoint
        
        drawing = Drawing()
        append(point: touchPoint)
        
        self.addSubview(drawing!)
    }
    //Add the new points as the touch is moved.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: self) as CGPoint
        append(point: touchPoint)
    }
    //If touch ends, end drawing.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: self) as CGPoint
        append(point: touchPoint)
        drawing = nil
    }

}
