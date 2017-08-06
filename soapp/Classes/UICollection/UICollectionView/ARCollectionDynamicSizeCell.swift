//The MIT License (MIT)
//
//Copyright (c) 2015
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import UIKit

extension UICollectionView{
    private struct associateKey{
        static var templeCellsKey = "templeCells"
    }
    
    private var templeCells : [String:AnyObject] {
        get{
            var dict = objc_getAssociatedObject(self, &associateKey.templeCellsKey) as? [String:AnyObject]
            if dict == nil {
                dict = Dictionary()
                objc_setAssociatedObject(self, &associateKey.templeCellsKey, dict!, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return dict!
        }
        
        set{
            objc_setAssociatedObject(self, &associateKey.templeCellsKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func ar_dynamicSize(reuseIdentifier:String,indexPath:IndexPath,configuration:((AnyObject)->Void),fixedWidth1:CGFloat = 0,fixedHeight:CGFloat = 0) -> CGSize {
        
        let cell = templeCell(reuseIdentifier: reuseIdentifier) as! UICollectionViewCell
        let fixedWidth = cell._width()
        
        
        cell.prepareForReuse()
        configuration(cell)
        
        
        
        if cell._height() > 1
        {
            

            return [fixedWidth, cell._height()]
        }

        
        if fixedWidth > 0 && fixedHeight > 0{
            return [fixedWidth, fixedHeight]
        }
        var fixedValue : CGFloat = 0
        var attribute : NSLayoutAttribute = NSLayoutAttribute.notAnAttribute
        if fixedWidth > 0 {
            fixedValue = fixedWidth
            attribute = NSLayoutAttribute.width
        }else if fixedHeight > 0{
            fixedValue = fixedHeight
            attribute = NSLayoutAttribute.height
        }
        
        let fixedLayout = NSLayoutConstraint(item: cell.contentView, attribute: attribute, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: attribute, multiplier: 1, constant: fixedValue)
        cell.contentView.addConstraint(fixedLayout)
        let size = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        cell.contentView.removeConstraint(fixedLayout)
        return size
    }
    
    
    private func templeCell(reuseIdentifier:String) -> AnyObject {
        var cell: AnyObject? = templeCells[reuseIdentifier]
        if cell == nil{
            //            let cellNibDict = self.valueForKey("_cellNibDict") as! [String:AnyObject]
            //            let cellNib = cellNibDict[reuseIdentifier] as! UINib
            //            cell = cellNib.instantiateWithOwner(nil, options: nil).last
            
            let cellClassDict = self.value(forKey: "_cellClassDict") as! [String:AnyObject]
            
            let cellClass = cellClassDict[reuseIdentifier] as! UICollectionViewCell.Type
            
            cell = cellClass.init(frame: [0])
            
            //            cell = cellNib.instantiateWithOwner(nil, options: nil).last
            templeCells[reuseIdentifier] = cell
            
        }
        return cell!
    }
    
    private func templeCellsDict() -> [String:Any]{
        let selector = "templeCellsDict"
        var dict = objc_getAssociatedObject(self, selector) as? [String:AnyObject]
        if dict == nil {
            dict = Dictionary()
            objc_setAssociatedObject(self, selector, dict, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return dict!
    }
}
