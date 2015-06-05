//
//  ParabolicTrajectoryModel.swift
//  AngryBirds
//
//  Created by Vaishali Mirchandani on 5/6/15.
//  Copyright (c) 2015 UPM. All rights reserved.
//

import Foundation

let EARTH_GRAVITY = 9.8067

class ParabolicTrajectoryModel {
    
    private var speedXaxis = 100.0
    private var speedYaxis = 100.0
    
    var objective = 100.0
    
    var speed: Double {
        get {
            return sqrt(speedXaxis*speedXaxis + speedYaxis*speedYaxis)
        }
        set {
            let a = angle
            speedXaxis = newValue * cos(angle)
            speedYaxis = newValue * sin(angle)
        }
    }
    
    var angle: Double {
        get {
            return atan2(speedYaxis, speedXaxis)
        }
        set {
            let s = speed
            speedXaxis = s * cos(newValue)
            speedYaxis = s * sin(newValue)
        }
    }
    
    init() {
    }
    
    init(speed:Double, angle:Double){
        speedXaxis = speed * cos(angle)
        speedYaxis = speed * sin(angle)
    }
    
    func height(time: Double) -> Double {
        return speedYaxis * time - 0.5 * time * time * EARTH_GRAVITY
    }
    
    func distance(time: Double) -> Double {
        return speedXaxis * time
    }
    
    func position(time:Double)-> (distance:Double, height:Double){
        return (distance(time), height(time))
    }
    
    func duration() -> Double {
        return (speedYaxis * 2)/EARTH_GRAVITY
    }
    
    func distanceObjective()->Double {
        return objective
    }
    
    subscript (time:Double)-> (distance:Double, height:Double){
        return position(time)
    }
    
}

