//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let cond = NSCondition()
var available = false
var SharedString = ""
var count = 10

class FirstThread : Thread {
    
    override func main(){
        for i in 0..<count {
            cond.lock()
            while(available){
                cond.wait()
            }
            SharedString = "🔴bee"
            print("\(SharedString):\(i)")
            available = true
            cond.signal()
            cond.unlock()
        }
    }
}

class SecondThread : Thread {
    
    override func main(){
        for i in 0..<count {
            cond.lock()
            while(!available){
                cond.wait()
            }
            SharedString = "🔵paaa"
            print("\(SharedString):\(i)")
            available = false
            cond.signal()
            cond.unlock()
        }
    }
}

let firstT = FirstThread()
let secondT = SecondThread()
firstT.start()
secondT.start()

PlaygroundPage.current.needsIndefiniteExecution = true
