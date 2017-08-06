//
//  GradientView.swift
//  joplane
//
//  Created by zhuxietong on 2016/10/8.
//  Copyright © 2016年 tong. All rights reserved.
//

import UIKit

public class GradientView:UIView{
    
    
    public var bottom_color = UIColor.clear
    
    public init(frame: CGRect,red:CGFloat,green:CGFloat,blue:CGFloat) {
        super.init(frame: frame)
        
        let lines:[CGFloat] = [0.0,0.5,1.0]
        
        let positions:[CGFloat] = [0.0,0.4,1.0]
        
        //颜色和position对应
        
        var colors = [CGColor]()
        let num = lines.count
        
        for (index,l) in lines.enumerated(){
            
            var rate = (num - index - 1).cg_floatValue/num.cg_floatValue //与向黑色过渡有关
            rate = rate + 0.2
            
            let ui_color = UIColor(red: red*rate, green: green*rate, blue: blue*rate, alpha: l)
            colors.append(ui_color.cgColor)
            
            bottom_color = ui_color
        }
        
        
        //将颜色和颜色的位置定义在数组内
        let gradientColors: [CGColor] = colors
        let gradientLocations: [CGFloat] = positions
        //创建CAGradientLayer实例并设置参数
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        gradientLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        
        
        
        //        let topColor = UIColor(red: (24/255.0), green: (24/255.0), blue: (24/255.0), alpha: 0.0)
        //        let midColor = UIColor(red: (24/255.0), green: (24/255.0), blue: (24/255.0), alpha: 0.5)
        //        let buttomColor = UIColor(red: (24/255.0), green: (24/255.0), blue: (24/255.0), alpha: 1.0)
        //        //将颜色和颜色的位置定义在数组内
        //        let gradientColors: [CGColor] = [topColor.cgColor,midColor.cgColor, buttomColor.cgColor]
        //        let gradientLocations: [CGFloat] = [0.0,0.5, 1.0]
        //
        //        //创建CAGradientLayer实例并设置参数
        //        let gradientLayer: CAGradientLayer = CAGradientLayer()
        //        gradientLayer.colors = gradientColors
        //        gradientLayer.locations = gradientLocations as [NSNumber]?
        //        gradientLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        //        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
