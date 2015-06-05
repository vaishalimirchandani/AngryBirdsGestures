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
    
    
    @IBAction func getSpeed(sender: UISlider) {
        parabolicTrajectoryModel.speed = Double(sender.value)
        speedValue.text = String(format:"%.2f m/s", arguments: [sender.value])
        parabolicTrayectory.setNeedsDisplay()
    }
    
    @IBAction func getAngle(sender: UISlider) {
        parabolicTrajectoryModel.angle = Double(sender.value)
        angleValue.text = String(format:"%.2f rad", arguments: [sender.value])
        parabolicTrayectory.setNeedsDisplay()
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


}

