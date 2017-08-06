//
//  UICollectionCell-model.swift
//  plane
//
//  Created by tong on 16/3/28.
//  Copyright © 2016年 tong. All rights reserved.
//

import Foundation

protocol CollectionCellSize {
    func _width() ->CGFloat
 
    
    func _height() ->CGFloat
  
}

extension UICollectionViewCell:CollectionCellSize {
    
    private struct CollectionAssociatedKeys {
        static var model = "model_key"
    }
    
        open func _width() ->CGFloat
    {
        return UIScreen.main.bounds.size.width
    }
    
    open func _height() ->CGFloat
    {
        return 0
    }

}
