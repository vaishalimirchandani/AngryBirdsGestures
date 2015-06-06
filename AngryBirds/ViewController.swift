//
//  ViewController.swift
//  AngryBirds
//
//  Created by Vaishali Mirchandani on 4/6/15.
//  Copyright (c) 2015 UPM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ParabolicTrajectoryViewDataSource {
    
    
    @IBOutlet weak var speedValue: UILabel!
    
    @IBOutlet weak var angleValue: UILabel!

    @IBOutlet weak var distanceValue: UILabel!
    
    @IBOutlet weak var speedSlider: UISlider!
    
    @IBOutlet weak var angleSlider: UISlider!

    @IBOutlet weak var distanceSlider: UISlider!

    @IBOutlet weak var parabolicTrayectory: ParabolicTrajectoryView!
    
    var parabolicTrajectoryModel:ParabolicTrajectoryModel!
    
    @IBAction func panChangeSpeed(sender: UIPanGestureRecognizer) {
        let position = sender.translationInView(sender.view!)
        let speed = parabolicTrajectoryModel.speed + Double(position.y)
        setSpeed(speed)
        sender.setTranslation(CGPointZero, inView: sender.view!)
    }

    @IBAction func rotationChangeAngle(sender: UIRotationGestureRecognizer) {
        //consiguir rotación y pintar
        let angle = Double(sender.rotation)
        setAngle(angle)
    }
    
    
    @IBAction func getSpeed(sender: UISlider) {
        let speed = Double(sender.value)
        setSpeed(speed)
    }
    
    @IBAction func getAngle(sender: UISlider) {
        let angle = Double(sender.value)
        setAngle(angle)
    }
    
    @IBAction func getDistance(sender: UISlider) {
        distanceSlider.maximumValue = Float(parabolicTrayectory.bounds.size.width-100)
        distanceValue.text = String(format: "%.2f m", arguments: [sender.value])
        parabolicTrajectoryModel.objective = Double(sender.value)+50
        parabolicTrayectory.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        parabolicTrayectory.dataSource = self
        parabolicTrajectoryModel = ParabolicTrajectoryModel()
        speedSlider.sendActionsForControlEvents(.ValueChanged)
        angleSlider.sendActionsForControlEvents(.ValueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startParabolicTrajectoryView()-> Double{
        return 0
    }
    
    func pointOfParabolicTrajectoryView(time:Double)-> (distance:Double,height:Double){
        let position = parabolicTrajectoryModel[time]
        return position
    }
    
    func endParabolicTrajectoryView ()->Double{
        return parabolicTrajectoryModel.duration()
    }
    
    func distanceToObjective() -> Double {
        return parabolicTrajectoryModel.objective
    }
    
    func setAngle(setAngle:Double){
        parabolicTrajectoryModel.angle = setAngle
        angleValue.text = String(format:"%.2f rad", arguments: [setAngle])
        parabolicTrayectory.setNeedsDisplay()
    }
    
    func setSpeed(setSpeed:Double){
        parabolicTrajectoryModel.speed = setSpeed
        speedValue.text = String(format:"%.2f m/s", arguments: [setSpeed])
        parabolicTrayectory.setNeedsDisplay()
    }
}

