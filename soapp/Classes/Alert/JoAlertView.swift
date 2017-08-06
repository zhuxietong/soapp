//
//  JoAlertView.swift
//  JoTravel
//
//  Created by otisaldridge on 15/9/28.
//  Copyright © 2015年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit
import Eelay

//typealias JoActionHander = (action:UIAlertAction)->()

//extension UIAlertAction {
//    convenience init(
//        name:String,
//        hander:(action:UIAlertAction)->()
//    )
//    {
//        self.init(title: name, style: style, handler: hander)
//    }
//}

extension String{
    
    public enum AlertType {
        case light
        case dark
    }
    
    public func showMessage(type:AlertType = .light)
    {
        let lable = UILabel()
        _ = lable.ui.center.text(hex: "#fff").text("\(self)").font17
        
        if let r_window = UIApplication.shared.delegate?.window
        {
            
//            let window = UIWindow(frame: UIScreen.main.bounds)
//            window.windowLevel = UIWindowLevelStatusBar
//            window.windowLevel = UIWindowLevelNormal + 500.0
//            window.backgroundColor = UIColor.white
//            window.layer.masksToBounds = true
//            window.isHidden = false
//            window.alpha = 1.0
//            window.makeKeyAndVisible()
//            
//            let imgV = UIImageView(frame: [40])
//            
//            window.addSubview(imgV)
            
            
            let btv = UIView()
            
            btv.layer.shadowOffset = [0,0]
            btv.layer.cornerRadius = 6
            btv.layer.shadowOpacity = 0.5
            btv.layer.shadowColor = UIColor.black.cgColor
            
            btv.backgroundColor = UIColor(white: 0, alpha: 0.3)
            
            
            
            
            let blurEffect = UIBlurEffectStyle.light
            let effect = UIBlurEffect(style: blurEffect)

            let effV = UIVisualEffectView()
            _ = effV.bsui.corner6
            effV.effect = effect
         
            
            
            
            lable.ui.line(0)
            
            let backV = UIView()
            
            let lays:TP.lays = [
                [backV,[ee.T.L.B.R]],
                [btv,[lable,ee.T,-16.&900],[lable,ee.B,16.&900],[lable,ee.L,-12.&900],[lable,ee.R,12.&900],[lable,ee.X.Y,[0.&950]],.>"80".&1000],
                [effV,[lable,ee.T,-16.&900],[lable,ee.B,16.&900],[lable,ee.L,-12.&900],[lable,ee.R,12.&900],[lable,ee.X.Y,[0.&950]],.>"80".&1000],
                [lable,[ee.X.Y,[0,-60.&1000]],[ee.L,.>(40.co)],[ee.R,.<(-40.co)],.>160.&1000,.>"21"],
            ]
            backV.alpha = 0.0
            btv.alpha = 0.0
            effV.alpha = 0.0
            lable.alpha = 0.0
            
            let cs = UIView.eelay(lays: UIView.eeformat(lays: lays), at: r_window!).1
            
            backV.backgroundColor = UIColor(white: 0.1, alpha: 0.1)
            
            var waite_time = self.len.cg_floatValue * 0.025
            if waite_time < 1.2{
                waite_time = 1.2.cg_floatValue
            }
            print(waite_time)
            
            
            UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                lable.alpha = 1
                effV.alpha = 1
                btv.alpha = 1.0
                backV.alpha = 1.0



                }, completion: { (finish) in
                    
                    
                    UIView.animate(withDuration: 0.25, delay: Double(waite_time), options: UIViewAnimationOptions.curveEaseOut, animations: {
                        lable.alpha = 0
                        effV.alpha = 0
                        btv.alpha = 0
                        backV.alpha = 0.0


                        }, completion: { (finish) in
                            lable.removeFromSuperview()
                            r_window!.removeConstraints(cs)
                    })
                    
            })
            
        }
        else
        {

        }
    }

    
    public func alert(){
        self.showMessage()
        
//            HUD.flash(.Label(self), delay: 1.0)
    }
}

public typealias Action = UIAlertAction

public extension UIAlertAction {
    convenience init(
        name:String?,
        style:UIAlertActionStyle = UIAlertActionStyle.default,
        hander:((UIAlertAction)->Void)? = nil
    )
    {
        self.init(title: name, style: style, handler: hander)
    }
}

public class JoAlertView {
    private var _title:String?
    private var _message:String?
    private var _canle:String?
    private var _style:UIAlertControllerStyle = .alert
    private var _actions = [UIAlertAction]()
        
//    private weak var _controller:AnyObject?
    
    public init(info:String...){
        switch info.count {
        case 1:
            _title = info[0]
        case 2:
            _title = info[0]
            _message = info[1]
        case 3:
            _title = info[0]
            _message = info[1]
            _canle = info[2]
        default:
            break
        }
    }
    

    public var sheet:JoAlertView  {self._style = .actionSheet;return self}
    public var alert:JoAlertView  {self._style = .alert;return self}
    
    public func title(_ title:String?) ->JoAlertView
    {
        self._title = title
        return self
    }
    
    public func message(_ message:String?) ->JoAlertView
    {
        self._message = message
        return self
    }
    public func style(_ style:UIAlertControllerStyle) ->JoAlertView
    {
        self._style = style
        return self
    }
    public func canle(_ canle:String?) -> JoAlertView {
        self._canle = canle
        return self
    }
    
    
    public func append(title:String,style:UIAlertActionStyle = .default,action:@escaping () -> Void) -> JoAlertView {
        
        let oneAc:((UIAlertAction)->Void) = {
            _ in
            action()
        }
        
        let ac = Action(name: title, style: style,hander: oneAc)
        self._actions.append(ac)
        return self
    }
    
    public func show(at controller:AnyObject?){
        
        if let ctr = controller as? UIViewController
        {
            let alert  = UIAlertController(title: self._title, message: self._message, canle: self._canle, style: self._style, actions: nil)
            for action in self._actions
            {
                alert.addAction(action)
            }
            ctr.present(alert, animated: true, completion: nil)
        }
    }

    
}



public extension UIAlertController
{
    
    public convenience init(
        title:String?,
        message:String? = nil,
        canle:String? = nil,
        style:UIAlertControllerStyle = UIAlertControllerStyle.actionSheet,
        actions:(UIAlertAction?)...
    )
    {
        self.init(title: title, message: message, preferredStyle: style)
        for item in actions
        {
            if let one = item
            {
                self.addAction(one)
            }
        }
        if let canleName = canle
        {
            let action_canle = UIAlertAction(title: canleName, style: UIAlertActionStyle.cancel, handler: { (alert:UIAlertAction) -> Void in
                
            })
            self.addAction(action_canle)
        }
    }
}






