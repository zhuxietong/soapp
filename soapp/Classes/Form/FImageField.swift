//
//  FImageField.swift
//  jocool
//
//  Created by tong on 16/6/13.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit
import Eelay

public class FImageField: FieldView,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    let titleL = UILabel()
    let imageV = UIImageView()
    
    weak var controller:UIViewController?
    
    override open func addLayoutRules() {
        
        
        let bt = UIButton()
        self.eelay = [
            [titleL,[ee.L,16],[ee.Y],110],
            [imageV,[ee.R,-8],[ee.T.B,[8,-8]],60,"60"],
            [bt,[ee.T.L.B.R]]
            
        ]
        
        addSubviews(titleL,imageV)
        

        bt.addTarget(self, action: #selector(chooseImg), for: UIControlEvents.touchUpInside)
        _ = titleL.ui.font16.cl_333
        
        
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    func chooseImg()
    {
        weak var wself = self
        
        JoAlertView(info: "提示","选择图片","取消").append(title: "拍照", action: {wself?.selectImage(index: 0)}).append(title: "图库选择", action: {wself?.selectImage(index: 1)}).sheet.show(at: self.controller)
        
    }
    
    override public func loadModelContent() {
              
        self.titleL.text = model["title",""]
        let value = model[FK.value,""]
        self.imageV.img_url = value
        if value == ""
        {
            let defaultV = model["defaultV",""]
            if defaultV != ""
            {
                model.setObject(defaultV, forKey: "value" as NSCopying)
                self.loadModelContent()
            }
        }
        
    }
    
    override public func get_string_value() -> String {
        return model["value",""].escapeHeadTailSpace()
    }
    
    
    
    func selectImage(index:NSInteger)
    {
        let picker:UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        if index == 1
        {
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        else
        {
            picker.sourceType = UIImagePickerControllerSourceType.camera
        }
        picker.allowsEditing = true
        self.controller?.present(picker, animated: true) { () -> Void in
        }
    }
    
    public func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        let smallPng = image.commpress(maxSize: 800)
        //        print("---===----nnnnn-dd---\(smallPng.saveToTemp().path)")
        //        self.uploadImage
        self.updateImg(img: smallPng)
        
        //        self.model.setObject(smallPng.saveToTemp().path, forKey: "path")
        //        self.loadModelContent()
        
        picker.dismiss(animated: true) { () -> Void in
            
        }
        
    }
    
    func updateImg(img:UIImage)
    {
        var file1 = UPImage(image:img)
        file1.fileName = model[FK.Img.name,"head.png"]
        file1.name = model[FK.Img.name,"head"]
        
        weak var wself = self
        let node = model[FK.Img.name,""]
        
        CoHud.loading()
        JoTask().log.log_response().url(model[FK.Img.upload,""]).params(["name":"ios"]).append(file: file1).json_handle { (succeed, message, obj, response) in
            CoHud.dismiss()
            if succeed
            {
                if let dict = obj as? NSMutableDictionary
                {
                    
                    wself!.imageV.image = img
                    
                    wself?.model.setObject(dict[node,""], forKey: FK.value as NSCopying)
                    wself!.succeedUploadImg()
                    wself!.loadModelContent()
                }
                "图片上传成功".alert()
                return
            }
            else
            {
                "图片上传失败".alert()
                
            }
            
            
            }.upload()
        

        
    }
    
    func succeedUploadImg()
    {
//        self.delegate?.touch(cell:self, actionID: "succeed_upload_img", model: self.model)
    }
    

    
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        
        picker.dismiss(animated: true) { () -> Void in
        }
    }
    
    
    
}

