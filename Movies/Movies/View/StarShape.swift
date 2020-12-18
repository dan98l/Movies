//
//  Star.swift
//  Movies
//
//  Created by Daniil G on 05.12.2020.
//  Copyright © 2020 Daniil G. All rights reserved.
//

import UIKit

@IBDesignable
class StarShape: UIView {
    
    var fillArea: CGFloat = 0.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var beams: Int = 5 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    private var pointiness: CGFloat = 2.5
    private var radius: CGFloat = 5.5
    private var range: CGFloat = 4.9
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
    
        let coordinates = CGPoint(x: (radius * 2.5), y: (radius * 2.5))
        
        let startAngle = CGFloat( -1 * (360 / beams / 4))
        
        let path = CGMutablePath()
        
        for index in 0...4 {
            starPath(path: path, coordinates: CGPoint(x: coordinates.x + (radius * CGFloat(index) * range), y: coordinates.y),
            radius: radius,
            beams: beams,
            pointyness: pointiness,
            startAngle: startAngle)
        }
        context.addPath(path)
        
        context.clip()
    
        context.setFillColor(red: 235, green: 117, blue: 0, alpha: 1)
//        context.setFillColor(red: 0, green: 0, blue: 0, alpha: 1)
        context.addRect(CGRect(x: 0, y: 0, width: self.frame.width * (0 + fillArea), height: self.frame.height))
        context.fillPath()
        
//        context.setFillColor(red: 179, green: 0, blue: 0, alpha: 1)
        context.setFillColor(red: 0, green: 0, blue: 0, alpha: 1)
        context.addRect(CGRect(x: self.frame.width * (0 + fillArea), y: 0, width: self.frame.width * (1 - fillArea), height: self.frame.height))
        context.fillPath()

        context.strokePath()
    }
    
    private func starPath(path: CGMutablePath, coordinates: CGPoint, radius: CGFloat, beams: Int, pointyness: CGFloat, startAngle: CGFloat = 0) -> CGMutablePath {
         
         let adjustment = startAngle + CGFloat( 360 / beams / 2)
         
         let innerСirclePoints = polygonPointArray(beams: beams, coordinates: coordinates, radius: radius, adjustment: startAngle)
         
         let outerCirclePoints = polygonPointArray(beams: beams, coordinates: coordinates, radius: radius * pointyness, adjustment: adjustment)
         
         path.move(to: innerСirclePoints[0])
         
         for index in 0..<innerСirclePoints.count {
             path.addLine(to: outerCirclePoints[index])
             path.addLine(to: innerСirclePoints[index])
         }
         
         path.closeSubpath()
         
         return path
     }

     private func radiansAngle(degree: CGFloat) -> CGFloat {
        return CGFloat(Double.pi) * degree / 180
     }

     private func polygonPointArray(beams: Int, coordinates: CGPoint, radius: CGFloat, adjustment: CGFloat = 0) -> [CGPoint] {
        
        let angle = radiansAngle(degree: 360 / CGFloat(beams))
        
        var points = [CGPoint]()
        
        for beam in 0...beams {
            points.append(CGPoint(x: (coordinates.x - radius * cos(angle * CGFloat(beams-beam) + radiansAngle(degree: adjustment))),
                                  y: (coordinates.y - radius * sin(angle * CGFloat(beams-beam) + radiansAngle(degree: adjustment)))))
        }
        
        return points
    }
}
