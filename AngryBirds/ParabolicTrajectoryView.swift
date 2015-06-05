//
//  ParabolicTrajectoryView.swift
//  AngryBirds
//
//  Created by Vaishali Mirchandani on 5/6/15.
//  Copyright (c) 2015 UPM. All rights reserved.
//

import Foundation
import UIKit

protocol ParabolicTrajectoryViewDataSource: class{
    func startParabolicTrajectoryView () -> Double
    func endParabolicTrajectoryView () -> Double
    func pointOfParabolicTrajectoryView (time:Double) -> (distance:Double, height:Double)
    func distanceToObjective() -> Double
}

@IBDesignable
class ParabolicTrajectoryView: UIView{
    
    var dataSource : ParabolicTrajectoryViewDataSource!
    
    #if TARGET_INTERFACE_BUILDER
        class FakeDataSource : ParabolicTrajectoryViewDataSource {
        
            func startParabolicTrajectoryView() -> Double {
                return 0.0
            }
            func endParabolicTrajectoryView() -> Double {
                return 100.0
            }
            func pointOfParabolicTrajectoryView(time: Double) -> (distance: Double, height: Double) {
                return(30.0,100.0)
            }
            func distanceToObjective()-> Double {
                return 100.0
            }
        }
        
        override func prepareForInterfaceBuilder() {
            strongDS=FakeDataSource()
            dataSource = strongDS
        }
    #endif
    
    override func drawRect(rect: CGRect) {
        if dataSource == nil {
            return
        }
        
        var path = UIBezierPath()
        
        let t_initial = dataSource.startParabolicTrajectoryView()
        let t_final = dataSource.endParabolicTrajectoryView()
        
        var position = dataSource.pointOfParabolicTrajectoryView(t_initial)
        
        var x = position.distance
        var y = position.height
        
        let h:Double = Double(bounds.size.height)
        
        path.moveToPoint(CGPointMake(CGFloat(x+20) ,CGFloat(h-y)))
        
        for var t=t_initial ; t<t_final ; t+=0.1 {
            let position = dataSource.pointOfParabolicTrajectoryView(t)
            path.addLineToPoint(CGPointMake(CGFloat(position.distance+20),CGFloat(h-position.height)))
        }
        
        path.lineWidth = 3
        UIColor.redColor().set()
        path.stroke()
        //drawLuke()
        //drawVader()
    }
    
    
    let IMG_SIZE = 50
    
    private func drawLuke(){
        if let img = UIImage(named: "Luke.png"){
            let y = bounds.size.height - CGFloat(IMG_SIZE)
            let rect = CGRectMake(0, y, CGFloat(IMG_SIZE), CGFloat(IMG_SIZE))
            img.drawInRect(rect)
        }
    }
    
    private func drawVader(){
        if let img = UIImage(named: "Vader.png"){
            let x = CGFloat(dataSource.distanceToObjective())
            let y = bounds.size.height - CGFloat(IMG_SIZE)
            let rect = CGRectMake(x, y, CGFloat(IMG_SIZE), CGFloat(IMG_SIZE))
            img.drawInRect(rect)
        }
    }
    
    private func drawBackground(){
        if let img = UIImage(named: "background.png"){
            let rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)
            img.drawInRect(rect)    }}
}