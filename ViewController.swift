//
//  ViewController.swift
//  BenFortier-Lab3
//
//  Created by Rena fortier on 9/27/18.
//  Copyright © 2018 Ben Fortier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//Initalize variables
    @IBOutlet weak var clear: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var undo: UIButton!
    @IBOutlet weak var canvas: UIView!
    @IBOutlet weak var lastColorButton: buttonClass!
    @IBOutlet weak var blue: buttonClass!
    @IBOutlet weak var green: buttonClass!
    @IBOutlet weak var yellow: buttonClass!
    @IBOutlet weak var orange: buttonClass!
    @IBOutlet weak var red: buttonClass!
     let button = UIButton()
       let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let randomObjects = ["Dog","Balloon","Cat","Car","Plane","Smiley Face", "Sun", "Flower"]
    var rainbow = false
    var rainVal = 0x0000
    var drawing: Drawing?
    var curColor: UIColor? = UIColor.red
    var lastColor: UIColor? = UIColor.clear
    var drawingArray: [Drawing] = [Drawing] () {
        didSet {
            enableButtons()
        }
    }
    
    //initial loading
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initalizeButtons()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //On begining of touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: canvas) as CGPoint
        let thick = CGFloat(slider.value)
        if (touchPoint.y >= view.frame.height -  85 ) {
            return
        }
        if rainbow {
            updateLast()
            curColor = getRandomColor()
        }
        let frame = CGRect(x: 0, y: 70, width: view.frame.width, height: view.frame.height - 200)
        drawing = Drawing(frame: frame)
        drawing!.circleArray = Circle(color: curColor!, points: [touchPoint], thickness: thick)
        view.addSubview(drawing!)
    }
    
    //while touch is moving
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: canvas) as CGPoint
        
        if (drawing == nil) {
            return
        }
        drawing!.circleArray?.points.append(touchPoint)
    }
    
    //end of touch
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = (touches.first)!.location(in: canvas) as CGPoint
        
        if (drawing == nil) {
            return
        }
        
        drawing!.circleArray?.points.append(touchPoint)
        drawingArray.append(drawing!)
        drawing = nil
    }

    //prevents undoing and getting a -index
    func enableButtons () {
        let enable: Bool = drawingArray.count > 0
        undo.isEnabled = enable
       // clear.isEnabled = enable

    }
    
    //clears screen
    @IBAction func clearScreen(_ sender: UIButton) {
        for draw in drawingArray{
            draw.removeFromSuperview()
        }
        drawingArray = [Drawing] ()
    }
    
    //undoes last drawing
    @IBAction func undoLast(_ sender: UIButton) {
        if (drawingArray.count > 0) {
            let remove: Drawing = drawingArray.removeLast()
            remove.removeFromSuperview()
        }
        
    }
    
    //Following functions deal with updating colors
    @IBAction func changeToRed(_ sender: buttonClass) {
        updateLast()
        rainbow = false
        hideBorders()
        red.showBorder = true
        curColor = .red
    }
    @IBAction func changeToOrange(_ sender: buttonClass) {
        updateLast()
        rainbow = false
        hideBorders()
        orange.showBorder = true
        curColor = .orange
    }
    @IBAction func changeToYellow(_ sender: buttonClass) {
        updateLast()
        rainbow = false
        hideBorders()
        yellow.showBorder = true
        curColor = .yellow
    }
    @IBAction func changeToGreen(_ sender: buttonClass) {
        updateLast()
        rainbow = false
        hideBorders()
        green.showBorder = true
        curColor = .green
    }
    @IBAction func changeToBlue(_ sender: buttonClass) {
        updateLast()
        rainbow = false
        hideBorders()
        blue.showBorder = true
        curColor = .blue
    }
    //hides borders of buttons if not selected
    func hideBorders(){
        red.showBorder = false
        orange.showBorder = false
        yellow.showBorder = false
        blue.showBorder = false
        green.showBorder = false
    }
    
    //****CREATIVE PORTION****
    
    //initializes buttons to be programtically added and removed from screen
    func initalizeButtons(){
        red.showBorder = true

        label.center = CGPoint(x: canvas.frame.width/2, y: canvas.frame.height+25)
        label.textAlignment = .center
        button.frame = CGRect(x: canvas.frame.size.width/2-50, y: self.view.frame.height-40, width: 100, height: 20)
        button.backgroundColor = UIColor.white
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        
        button.setTitle("Submit Drawing", for: .normal)
        button.addTarget(self, action: #selector(submitDrawing), for: .touchDown)
    }

    //gives users the random drawing
    @IBAction func giveMeDrawing(_ sender: UIButton) {
        let length = randomObjects.count
        let numb = Int(arc4random_uniform(UInt32(length)))
        let randomThing = randomObjects[numb]
        label.text = "Draw: \(randomThing)"
        self.view.addSubview(label)
        self.view.addSubview(button)
    }
    
   @objc func submitDrawing() {
    label.removeFromSuperview()
    button.removeFromSuperview()
    for draw in drawingArray{
        draw.removeFromSuperview()
    }
    drawingArray = [Drawing] ()
    
    
    
    }
   
    @IBAction func changeToLastColor(_ sender: buttonClass) {
        rainbow = false
        curColor = lastColor
    }
    
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0/(red+green+blue))
    }

 
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            print("bad")
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
  


   
    @IBAction func changeToRainbow(_ sender: buttonClass) {
        rainbow = true
        hideBorders()
    }
   
    

   
 
    func updateLast(){
        lastColor = curColor
        lastColorButton.backgroundColor = lastColor

    }
  
    
  


}

