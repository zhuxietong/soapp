//
//  CoFlowLayout.swift
//  jocool
//
//  Created by tong on 16/8/23.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import UIKit



public class CoFlowLayout: UICollectionViewFlowLayout {
    
    public var zoom_factor:CGFloat =  0.1
    public var active_distance:CGFloat = 200
    
    
    public init(size:CGSize) {
        super.init()
        self.itemSize = size
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 20
//        self.minimumInteritemSpacing = 15
        self.sectionInset = [64,20,10,20]
    }
    
    public override init() {
        super.init()
        self.itemSize = [250,350]
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 15
        self.sectionInset = [10,10,10,10]
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array_obj = super.layoutAttributesForElements(in: rect)
        var visibleRect:CGRect = []
        if let off = self.collectionView?.contentOffset
        {
            visibleRect.origin = off
        }
        if let s = self.collectionView?.bounds.size
        {
            visibleRect.size = s
        }
        
        if let array = array_obj
        {
            for attributes in array
            {
                if attributes.frame.intersects(rect)
                {
                    var distance = visibleRect.midX - attributes.center.x
                    distance = abs(distance)
                    if distance < (Swidth/2.0 + self.itemSize.width)
                    {
                        let zoom = 1 + self.zoom_factor*(1-distance/active_distance)
                        attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0)
                        attributes.transform3D = CATransform3DTranslate(attributes.transform3D, 0 , -zoom * 25, 0)
                        attributes.alpha = zoom - zoom_factor
                        
                    }
                }
            }
        }
        
        return array_obj
    }
    
    
    
    public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        
        var offsetAdjustment:CGFloat = CGFloat.greatestFiniteMagnitude
        
        let horizontalCenter:CGFloat = proposedContentOffset.x + (self.collectionView!.bounds.width / 2.0)
        
        let targetRect = CGRect(x:proposedContentOffset.x, y: 0.0, width: self.collectionView!.bounds.size.width, height: self.collectionView!.bounds.size.height)
        if let array = super.layoutAttributesForElements(in: targetRect)
        {
            for layoutAttributes in array {
                let itemHorizontalCenter = layoutAttributes.center.x
                if (abs(itemHorizontalCenter - horizontalCenter) < abs(offsetAdjustment))
                {
                    offsetAdjustment = itemHorizontalCenter - horizontalCenter
                }
            }
            
        }
        
       
        return [(proposedContentOffset.x + offsetAdjustment), proposedContentOffset.y]
    }
    

}


