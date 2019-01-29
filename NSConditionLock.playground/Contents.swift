//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let NO_DATA = 1
let GOT_DATA = 2
let clock = NSConditionLock(condition: NO_DATA)
var SharedString = ""
var count = 10

class ProducerThread : Thread {
    
    override func main(){
        for i in 0..<count {
            clock.lock(whenCondition: NO_DATA)
            SharedString = "🔴bee"
            print("\(SharedString):\(i)")
            clock.unlock(withCondition: GOT_DATA)
        }
    }
}

class ConsumerThread : Thread {
    
    override func main(){
        for i in 0..<count {
            clock.lock(whenCondition: GOT_DATA)
            SharedString = "🔵paaa"
            print("\(SharedString):\(i)")
            clock.unlock(withCondition: NO_DATA)
        }
    }
}

let pt = ProducerThread()
let ct = ConsumerThread()
ct.start()
pt.start()

PlaygroundPage.current.needsIndefiniteExecution = true
