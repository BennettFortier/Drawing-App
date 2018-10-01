//
//  buttonClass.swift
//  BenFortier-Lab3
//
//  Created by Rena fortier on 9/27/18.
//  Copyright © 2018 Ben Fortier. All rights reserved.
//

import UIKit
@IBDesignable
class buttonClass: UIButton {
    //Radius of button, needed to make it round.
   @IBInspectable var radius:CGFloat = 0{
        didSet{
           self.layer.cornerRadius = radius
        }
    }
    //Variable to determine which is selected
    var showBorder: Bool = false{
        didSet{
            if showBorder {
                self.layer.borderWidth = 3
                self.layer.borderColor = UIColor.black.cgColor
            }
            else{
                self.layer.borderWidth = 0
            }
        }
    }
    
    @IBInspectable var color:UIColor = UIColor.clear{
        didSet{
            self.backgroundColor = color
        }
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    


}
