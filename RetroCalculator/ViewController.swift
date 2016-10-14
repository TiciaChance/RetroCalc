//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Laticia Chance on 10/9/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet weak var calcLabel: UILabel!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case empty = "Empty"
    }
    
    var currentOperation = Operation.empty
    var leftValueString = ""
    var rightValueString = ""
    var result = ""
    
    var buttonSound = AVAudioPlayer()
    
    var runningNum = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOf: soundURL)
            buttonSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        
        playSound()
        
        runningNum += "\(sender.tag)"
        
        calcLabel.text = runningNum
        
        
    }
    
    
    @IBAction func divideButtonTapped(_ sender: AnyObject) {
        processOperation(operation: .Divide)
    }
 
    @IBAction func multiplyButtonTapped(_ sender: AnyObject) {
        processOperation(operation: .Multiply)

    }
    
    @IBAction func subtractButtonTapped(_ sender: AnyObject) {
        processOperation(operation: .Subtract)

    }
    
    @IBAction func additionButtonTapped(_ sender: AnyObject) {
        processOperation(operation: .Add)

    }
    
    @IBAction func equalButtonTapped(_ sender: AnyObject) {
        processOperation(operation: currentOperation)

    }
    
    
    func playSound() {
        
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
    //left hand value + operator + right hand value = result/running number
    
    func processOperation(operation: Operation) {
        
        buttonSound.play()
        
        if currentOperation != Operation.empty {
            
            // a check in case user selects an operator, but then selects another operator without first entering a # first
            if !runningNum.isEmpty {
                
                rightValueString = runningNum
                runningNum = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValueString)! * Double(rightValueString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValueString)! / Double(rightValueString)!)"
                    
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValueString)! - Double(rightValueString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValueString)! + Double(rightValueString)!)"
                    
                }
                
                leftValueString = result
                calcLabel.text = result
            }
            currentOperation = operation
        } else {
           
            // if it is the first time the operation has been pressed
            leftValueString = runningNum
            runningNum = ""
            
            currentOperation = operation
        }
        
        
    }
}
