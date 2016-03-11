//
//  ViewController.swift
//  retro-calculator
//
//  Created by Nikita Buyevich on 3/3/16.
//  Copyright © 2016 Nikita Buyevich. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = "0"
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
      
      if runningNumber != "0" {
        runningNumber += "\(btn.tag)"
      } else {
        runningNumber = "\(btn.tag)"
      }
        outputLbl.text = runningNumber
    }
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    @IBAction func onCLearPressed(sender: AnyObject) {
      playSound()
      runningNumber = "0"
      leftValStr = "0"
      rightValStr = "0"
      currentOperation = Operation.Empty
      result = "0"
      outputLbl.text = "0"
    }
    
    func processOperation(op: Operation) {
      playSound()
      
      // A user selected an operator, but then selected another opeartor 
      if currentOperation != Operation.Empty {
        if runningNumber != "0" {
          rightValStr = runningNumber
          runningNumber = "0"
          
          if currentOperation == Operation.Multiply {
            result = "\(Double(leftValStr)! * Double(rightValStr)!)"
          } else if currentOperation == Operation.Divide {
            result = "\(Double(leftValStr)! / Double(rightValStr)!)"
          } else if currentOperation == Operation.Add {
            result = "\(Double(leftValStr)! + Double(rightValStr)!)"
          } else if currentOperation == Operation.Subtract {
            result = "\(Double(leftValStr)! - Double(rightValStr)!)"
          }
          
          leftValStr = result
          outputLbl.text = result
        }
        currentOperation = op
      
      } else {
        // first time operator pressed 
        leftValStr = runningNumber
        runningNumber = "0"
        currentOperation = op
      }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
}

