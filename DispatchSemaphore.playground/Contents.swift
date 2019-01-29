import Foundation
import PlaygroundSupport
var count = 10
var available = false
var SharedString = ""

let priorityA = DispatchQueue.global(qos: .utility)
let priorityB = DispatchQueue.global(qos: .utility)

let semaphore = DispatchSemaphore(value: 1)

func asyncPrintA(queue: DispatchQueue, symbol: String) {
    queue.async {
        
        for i in 0..<count {
            while(available){
                semaphore.wait()  // requesting the resource
            }
            SharedString = symbol
            print("\(symbol):\(i)")
            available = true
            semaphore.signal() // releasing the resource
        }
    }
}

func asyncPrintB(queue: DispatchQueue, symbol: String) {
    queue.async {
        
        for i in 0..<count {
            while(!available){
                semaphore.wait()  // requesting the resource
            }
            SharedString = symbol
            print("\(symbol):\(i)")
            available = false
            semaphore.signal() // releasing the resource
        }
    }
}

asyncPrintA(queue: priorityA, symbol: "🔴bee")
asyncPrintB(queue: priorityB, symbol: "🔵paaa")

PlaygroundPage.current.needsIndefiniteExecution = true
