//
//  AsyncUpload.swift
//  XPApp
//
//  Created by zhuxietong on 2017/2/9.
//  Copyright © 2017年 zhuxietong. All rights reserved.
//

import UIKit


public enum TaskStatus {
    case waiting
    case success
    case failed
}



public protocol AsyncTaskDelegate:NSObjectProtocol {
    func finish(task:AsyncTask)
}

public protocol AsyncTask {
    
    var queIndex:Int{get set}
    
    var status:TaskStatus{get set}
    
    weak var delegate:AsyncTaskDelegate?{set get}

    
    func startTask()

    func canleTask()
    
    func finish(success: Bool, objs: Any...)
}



open class AsynJoTask:AsyncTask{
    
    weak public var delegate:AsyncTaskDelegate? = nil
    public var queIndex: Int = 0
    public var status: TaskStatus = .waiting
   
    open func startTask(){
//        JoTask().json_handle { (success, msg, obj, res) in
//            
//        }
        
    }
    
    public init() {
        
    }
    
    open func canleTask() {
        
    }
    
    open func finish(success: Bool, objs: Any...) {

        if success{
            self.status = .success
        }
        else{
            self.status = .failed
        }
  
        self.delegate?.finish(task: self)
    }
}



public enum AsyncProgress {
    case success
    case failed(count:Int,task:AsyncTask)
    case `continue`(count:Int,task:AsyncTask)
}


var task_identify:Int = 0


public class AsyncQue:NSObject,AsyncTaskDelegate{
    
    public var isInProcess = false
    
    public static var `default` = AsyncQue()
    
    public func finish(task: AsyncTask) {
//        debugPrint("===--status|\(self.successTasks.count)")

        if isInProcess
        {
//            debugPrint("===sssdd--status|\(self.successTasks.count)")

            if task.status == .failed{
                let gress = AsyncProgress.failed(count: successTasks.count, task: task)
                self.progress(gress)
                self.isInProcess = false
                self.stopProcessingTasks()
            }
            else{
//                debugPrint("==---ss=--dddds|\(self.successTasks.count)")

                if self.successTasks.count >= self.tasks.count{
//                    debugPrint("===--dddds|\(self.successTasks.count)")

                    let gress = AsyncProgress.success
                    self.progress(gress)
                    self.isInProcess = false

                }
                else{
                    let gress = AsyncProgress.continue(count: successTasks.count, task: task)
                    self.progress(gress)
                }
            }
        }
    }

    
    
    public var tasks = [AsyncTask]()
    
    
    public var successTasks:[AsyncTask]{
        return tasks.filter {$0.status == .success}
    }
    
    public var failedTasks:[AsyncTask]{
        return tasks.filter {$0.status == .failed}
    }
  
    public var waitingTasks:[AsyncTask]{
        return tasks.filter {$0.status == .waiting}
    }

    
    
    
    public var progress:(AsyncProgress)->Void = {_ in}
    
    public func stopProcessingTasks() {
        let waitings = self.waitingTasks
        for one in waitings{
           one.canleTask()
        }
    }
    
    public func start(tasks:[AsyncTask],progress:@escaping (AsyncProgress)->Void) {
        self.tasks = tasks
        self.progress = progress
        
        self.isInProcess = true
//        let que = DispatchQueue(label: "AsyncTask.task", attributes: .concurrent)
        
        let que = OperationQueue()
        que.maxConcurrentOperationCount = -1
        
        var ques = [BlockOperation]()
        for (index,one) in self.tasks.enumerated(){
            var task = one
            task.delegate = self
            task.queIndex = index
            let op = BlockOperation(block: { 
                
//                debugPrint("start-\(index)|\(Thread.current)")
//                sleep(1)
//                debugPrint("finish-\(index)|\(Thread.current)")
                task.startTask()


            })
            
            ques.append(op)
//            que.addOperation(op)
            
//            que.async {
//                task_identify = task_identify + 1
//                task.startTask()
//            }

        }
        que.addOperations(ques, waitUntilFinished: false)
        
        
    }
    
    
}
