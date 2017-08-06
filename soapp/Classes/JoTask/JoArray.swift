import Foundation
import UIKit



internal class JoArrayGenerator<T>:IteratorProtocol
{
    typealias Element = T
    var list:NSArray
    var validate_list = NSMutableArray()
    
    var count:Int = 0
    init(list:NSArray)
    {
        self.list = list
        
        validate_list.removeAllObjects()
        for obj in self.list
        {
            if let _ = obj as? T
            {
                validate_list.add(obj)
            }
        }
        self.count = 0
    }
    
    
    func next() -> Element? {
        if self.count < self.validate_list.count
        {
            let one = self.validate_list[count] as? Element
            count += 1
            
            return one
        }
        
        self.count  = 0
        return nil
        
    }
    
}

class JoArray<T> :Sequence{
    
    typealias Iterator = JoArrayGenerator<T>
    var list:NSArray
    
    func makeIterator() -> Iterator {
        return JoArrayGenerator(list: list)
    }
    
    init(list:NSArray)
    {
        self.list = list
    }
    
}

public extension NSArray
{
    public func reverse_list<T>(_ block:(T,Int)->Void) {
        let list = self.reversed()
        var index:Int = 0
        for one in JoArray<T>(list: list as NSArray)
        {
            block(one,index)
            index += 1
        }
    }
    
    public func list<T>(_ block:(T,Int)->Void)
    {
        
        var index:Int = 0
        for one in JoArray<T>(list: self)
        {
            block(one,index)
            index += 1
        }
        
    }
    
    
    public func listObj<T>(_ block:(T)->Void)
    {
        
        for one in JoArray<T>(list: self)
        {
            block(one)
        }
        
    }
    
    
}

public extension Array{
    
    public func new<T,Obj>(_ creator:(Int,Obj)throws->T) ->[T]{
        
        var new_list = [T]()
        for (index,one) in self.enumerated()
        {
            if let o = one as? Obj
            {
                do {
                    let one = try creator(index,o)
                    new_list.append(one)
                } catch {
                    print(error)
                }
                
                
            }
        }
        return new_list
    }
}



