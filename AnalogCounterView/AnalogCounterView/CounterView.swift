//
//  CounterView.swift
//  Flo
//
//  Created by mac on 24/10/18.
//  Copyright © 2018 Dominator. All rights reserved.
//

import UIKit

@IBDesignable public class CounterView: UIView {
    
    private struct Constants {
        static let lineWidth: CGFloat = 5.0
        static let arcWidth: CGFloat = 76
        
        static var halfOfLineWidth: CGFloat {
            return lineWidth / 2
        }
    }
    @IBInspectable public var numberOfItem:Int = 8
    @IBInspectable public var counter: Int = 5{didSet{
       
        setNeedsDisplay()
        }}
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.orange
    @IBInspectable var counterFontSize : CGFloat = 36
    let label = UILabel()
    override public func draw(_ rect: CGRect) {
        // 1
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        // 2
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        // 3
        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = .pi / 4
        
        // 4
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - Constants.arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        // 5
        path.lineWidth = Constants.arcWidth
        counterColor.setStroke()
        path.stroke()
        
        //Draw the outline
        
        //1 - first calculate the difference between the two angles
        //ensuring it is positive
        let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
        //then calculate the arc for each single glass
        let arcLengthPerGlass = angleDifference / CGFloat(self.numberOfItem)
        //then multiply out by the actual glasses drunk
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter > 0 && counter <= self.numberOfItem ? counter : counter < 0 ? 0 : counter < self.numberOfItem ? counter : self.numberOfItem) + startAngle
        
        //2 - draw the outer arc
        let outlinePath = UIBezierPath(arcCenter: center,
                                       radius: bounds.width/2 - Constants.halfOfLineWidth,
                                       startAngle: startAngle,
                                       endAngle: outlineEndAngle,
                                       clockwise: true)
        
        //3 - draw the inner arc
        outlinePath.addArc(withCenter: center,
                           radius: bounds.width/2 - Constants.arcWidth + Constants.halfOfLineWidth,
                           startAngle: outlineEndAngle,
                           endAngle: startAngle,
                           clockwise: false)
        
        //4 - close the path
        outlinePath.close()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = Constants.lineWidth
        outlinePath.stroke()
        
        let innerDia = 2 * ((radius/2) - Constants.arcWidth)
        let labelSide = sqrt(innerDia * innerDia / 2)
        
        label.frame = CGRect(x: bounds.midX - labelSide/2, y: bounds.midY - labelSide/2, width: labelSide, height: labelSide)
        label.text = "\(counter > 0 && counter <= self.numberOfItem ? counter : counter < 0 ? 0 : counter < self.numberOfItem ? counter : self.numberOfItem)"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: counterFontSize)
        label.backgroundColor = .clear
       
        addSubview(label)
    }
}

