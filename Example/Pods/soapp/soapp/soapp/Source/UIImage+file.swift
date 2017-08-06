//
//  UIImage+file.swift
//  JoTravel
//
//  Created by tong on 15/10/26.
//  Copyright © 2015年 zhuxietong. All rights reserved.
//

import Foundation
import UIKit

//压缩图片，任意大小的图片压缩到100K以内
////压缩图像
//+(NSData *)imageData:(UIImage *)myimage
//{
//    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
//    if (data.length>100*1024) {
//        if (data.length>1024*1024) {//1M以及以上
//            data=UIImageJPEGRepresentation(myimage, 0.1);
//        }else if (data.length>512*1024) {//0.5M-1M
//            data=UIImageJPEGRepresentation(myimage, 0.5);
//        }else if (data.length>200*1024) {//0.25M-0.5M
//            data=UIImageJPEGRepresentation(myimage, 0.9);
//        }
//    }
//    return data;
//}

//- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize
//{
//    //先调整分辨率
//    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
//
//    CGFloat tempHeight = newSize.height / 1024;
//    CGFloat tempWidth = newSize.width / 1024;
//
//    if (tempWidth > 1.0 && tempWidth > tempHeight) {
//        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
//    }
//    else if (tempHeight > 1.0 && tempWidth < tempHeight){
//        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
//    }
//
//    UIGraphicsBeginImageContext(newSize);
//    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    //调整大小
//    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
//    NSUInteger sizeOrigin = [imageData length];
//    NSUInteger sizeOriginKB = sizeOrigin / 1024;
//    if (sizeOriginKB > maxSize) {
//        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.50);
//        return finallImageData;
//    }
//
//    return imageData;
//}
extension UIImage
{
    
    public func commpress(maxSize:Int) ->UIImage
    {
        let source_image = self
        var newSize:CGSize = [source_image.size.width, source_image.size.height]
        let tempHeight = newSize.height/1024
        let tempWidth = newSize.width/1024
        
        if (tempWidth > 1.0 && tempWidth > tempHeight) {
            newSize = [source_image.size.width / tempWidth, source_image.size.height / tempWidth]
        }
        else if (tempHeight > 1.0 && tempWidth < tempHeight){
            newSize = [source_image.size.width / tempHeight, source_image.size.height / tempHeight]
        }
        
        UIGraphicsBeginImageContext(newSize);
        
        source_image.draw(in: [0,0,newSize.width,newSize.height])
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imageData = UIImageJPEGRepresentation(newImage!,1.0)
        
        let sizeOrigin = imageData?.count
        let sizeOriginKB = sizeOrigin! / 1024
        
        if (sizeOriginKB > maxSize)
        {
            let finallImageData = UIImageJPEGRepresentation(newImage!,0.50)
            
            return UIImage(data: finallImageData!)!
        }
        return UIImage(data: imageData!)!
    
    }
    
    public var net_image:UIImage
        {
        get{
            
            let o_size = self.size
            var width:CGFloat = o_size.width
            var height:CGFloat = o_size.height
            
            let limit_s:CGFloat = 800
            if o_size.width > limit_s
            {
                width = limit_s
                height =  width / (o_size.width/o_size.height)
            }
            if height > limit_s
            {
                height = limit_s
                width = height / (o_size.height/o_size.width)
            }
            
            
            UIGraphicsBeginImageContext(CGSize(width: width, height: height))
            let rc:CGRect = [0,0,width,height]
            self.draw(in: rc)
            let thumbImage=UIGraphicsGetImageFromCurrentImageContext()
            
            //            UIGraphicsEndImageContext()
            let image_data = UIImageJPEGRepresentation(thumbImage!, 0.5)
            //            let d = UIImagePNGRepresentation(thumbImage)

            
            return UIImage(data: image_data!)!
        }
        
    }
    
    //    func scaleCompress(image: UIImage!, scale: CGFloat) -> UIImage {
    //        UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scale,image.size.height * scale));
    //        image.drawInRect(CGRectMake(0, 0, image.size.width * scale, image.size.height * scale))
    //        let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    //        UIGraphicsEndImageContext();
    //        return scaledImage
    //    }
    
    
    func pngImg() ->UIImage
    {
        let data = UIImagePNGRepresentation(self)
        return UIImage(data: data!)!
    }
    
}
