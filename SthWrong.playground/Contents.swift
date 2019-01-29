//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

var SharedString = ""
var count = 10

class ProducerThread : Thread {
    
    override func main(){
        for i in 0..<count {
            SharedString = "🔴bee"
            print("\(SharedString):\(i) Current thread \(Thread.current)")
            
        }
    }
}

class ConsumerThread : Thread {
    
    override func main(){
        for i in 0..<count {
            SharedString = "🔵paaa"
            print("\(SharedString):\(i) Current thread \(Thread.current)")
        }
    }
}

let pt = ProducerThread()
let ct = ConsumerThread()
ct.start()
pt.start()

PlaygroundPage.current.needsIndefiniteExecution = true
