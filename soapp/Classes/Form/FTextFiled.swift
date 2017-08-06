//
//  FTextFiled.swift
//  jocool
//
//  Created by tong on 16/6/11.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit
import Eelay

public class FTextField: FieldView, UITextFieldDelegate
{
    public let valueT = UITextField()
    
    
    override public func addLayoutRules() {

        
        self.eelay = [
            [valueT,[ee.T.L.B.R.Y]]
        ]

        valueT.delegate = self        
        valueT.textColor = UIColor(shex: "#333333")
        valueT.font = UIFont.systemFont(ofSize: 15)
        
        NotificationCenter.default.addObserver(valueT, selector: #selector(resignFirstResponder), name: NSNotification.Name(rawValue: FK.SaveJoFormNotify), object: nil)
        
        
    }
    
    
    public override func get_string_value() -> String {
        
        self.valueT.resignFirstResponder()
        model.setObject(self.valueT.text!, forKey: "value" as NSCopying)
        return model["value",""].escapeHeadTailSpace()
    }

    
    
   public override func loadModelContent() {
        
        valueT.text = model[FK.value,""]
        valueT.ui.font(font:FieldView.valueStyle.font).text(color: FieldView.valueStyle.color)
        valueT.placeholder = place_holder
        valueT.setPlaceholder(info: (place_holder,FieldView.holderStyle.color,FieldView.holderStyle.font))
    
        let value = model[FK.value,""]
        if value == ""
        {
            let defaultV = model["defaultV",""]
            if defaultV != ""
            {
                model.setObject(defaultV, forKey: FK.value as NSCopying)
                self.loadModelContent()
            }
            
        }
    
        if model[FK.editble,"YES"] == "NO"
        {
            valueT.isUserInteractionEnabled = false
        }
        else
        {
            valueT.isUserInteractionEnabled = true
        }
        
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        model.setObject(textField.text!, forKey: FK.value as NSCopying)
        
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "\n"
        {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    deinit
    {
        NotificationCenter.default.removeObserver(valueT, name: NSNotification.Name(rawValue: FK.SaveJoFormNotify), object: nil)
    }
}
