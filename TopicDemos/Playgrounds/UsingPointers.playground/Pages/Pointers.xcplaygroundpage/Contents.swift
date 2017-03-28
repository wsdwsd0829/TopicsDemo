//: [Previous](@previous)

import Foundation

MemoryLayout<Int>.size          // returns 8 (on 64-bit)
MemoryLayout<Int>.alignment     // returns 8 (on 64-bit)
MemoryLayout<Int>.stride        // returns 8 (on 64-bit)

MemoryLayout<Int16>.size        // returns 2
MemoryLayout<Int16>.alignment   // returns 2
MemoryLayout<Int16>.stride      // returns 2

MemoryLayout<Bool>.size         // returns 1
MemoryLayout<Bool>.alignment    // returns 1
MemoryLayout<Bool>.stride       // returns 1

MemoryLayout<Float>.size        // returns 4
MemoryLayout<Float>.alignment   // returns 4
MemoryLayout<Float>.stride      // returns 4

MemoryLayout<Double>.size       // returns 8
MemoryLayout<Double>.alignment  // returns 8
MemoryLayout<Double>.stride     // returns 8

//Struct
struct EmptyStruct {}

MemoryLayout<EmptyStruct>.size      // returns 0
MemoryLayout<EmptyStruct>.alignment // returns 1
MemoryLayout<EmptyStruct>.stride    // returns 1

struct SampleStruct {
    let number: UInt32
    let flag: Bool
}

MemoryLayout<SampleStruct>.size       // returns 5
MemoryLayout<SampleStruct>.alignment  // returns 4
MemoryLayout<SampleStruct>.stride     // returns 8

//Class
class EmptyClass {}

MemoryLayout<EmptyClass>.size      // returns 8 (on 64-bit)
MemoryLayout<EmptyClass>.stride    // returns 8 (on 64-bit)
MemoryLayout<EmptyClass>.alignment // returns 8 (on 64-bit)

class SampleClass {
    let number: Int64 = 0
    let flag: Bool = false
}

MemoryLayout<SampleClass>.size      // returns 8 (on 64-bit)
MemoryLayout<SampleClass>.stride    // returns 8 (on 64-bit)
MemoryLayout<SampleClass>.alignment // returns 8 (on 64-bit)

//================================================
// 1
let count = 2
let stride = MemoryLayout<Int>.stride
let alignment = MemoryLayout<Int>.alignment
let byteCount = stride * count

// 2
do {
    print("Raw pointers")
    
    // 3
    let pointer = UnsafeMutableRawPointer.allocate(bytes: byteCount, alignedTo: alignment)
    // 4
    defer {
        pointer.deallocate(bytes: byteCount, alignedTo: alignment)
    }
    
    // 5
    pointer.storeBytes(of: 42, as: Int.self)
    pointer.advanced(by: stride).storeBytes(of: 6, as: Int.self)
    pointer.load(as: Int.self)
    pointer.advanced(by: stride).load(as: Int.self)
    
    // 6
    let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: byteCount)
    for (index, byte) in bufferPointer.enumerated() {
        print("byte \(index): \(byte)")
    }
}

do {
    print("Typed pointers")
    
    let pointer = UnsafeMutablePointer<Int>.allocate(capacity: count)
    pointer.initialize(to: 0, count: count)
    defer {
        pointer.deinitialize(count: count)
        pointer.deallocate(capacity: count)
    }
    
    pointer.pointee = 42
    pointer.advanced(by: 1).pointee = 6
    pointer.pointee
    pointer.advanced(by: 1).pointee
    
    let bufferPointer = UnsafeBufferPointer(start: pointer, count: count)
    for (index, value) in bufferPointer.enumerated() {
        print("value \(index): \(value)")
    }
}

do {
    print("Converting raw pointers to typed pointers")
    
    let rawPointer = UnsafeMutableRawPointer.allocate(bytes: byteCount, alignedTo: alignment)
    defer {
        rawPointer.deallocate(bytes: byteCount, alignedTo: alignment)
    }
    
    let typedPointer = rawPointer.bindMemory(to: Int.self, capacity: count)
    typedPointer.initialize(to: 0, count: count)
    defer {
        typedPointer.deinitialize(count: count)
    }
    
    typedPointer.pointee = 42
    typedPointer.advanced(by: 1).pointee = 6
    typedPointer.pointee
    typedPointer.advanced(by: 1).pointee
    
    let bufferPointer = UnsafeBufferPointer(start: typedPointer, count: count)
    for (index, value) in bufferPointer.enumerated() {
        print("value \(index): \(value)")
    }
}

do {
    print("Getting the bytes of an instance")
    
    var sampleStruct = SampleStruct(number: 25, flag: true)
    
    withUnsafeBytes(of: &sampleStruct) { bytes in
        for byte in bytes {
            print(byte)
        }
    }
}

do {
    print("Checksum the bytes of a struct")
    
    var sampleStruct = SampleStruct(number: 25, flag: true)
    
    let checksum = withUnsafeBytes(of: &sampleStruct) { (bytes) -> UInt32 in
        return ~bytes.reduce(UInt32(0)) { $0 + numericCast($1) }
    }
    
    print("checksum", checksum) // prints checksum 4294967269
}

//================================================


//Int to UnsafeMutablePointer
do {
    func incrementor(ptr: UnsafeMutablePointer<Int>) {
        ptr.pointee += 1
    }

    var a = 10
    incrementor(ptr: &a)

    a  // 11
    //let b = &a cannot access directly
}
import Accelerate
do {
    

    let a: [Float] = [1, 2, 3, 4]
    let b: [Float] = [0.5, 0.25, 0.125, 0.0625]
    var result: [Float] = [0, 0, 0, 0]

    vDSP_vadd(a, 1, b, 1, &result, 1, 4)
    result

    // result now contains [1.5, 2.25, 3.125, 4.0625]
}
do {
    var array = [1, 2, 3, 4, 5]
    var arrayPtr = UnsafeMutableBufferPointer<Int>(start: &array, count: array.count)
    // baseAddress 是第一个元素的指针
    var basePtr = arrayPtr.baseAddress! as UnsafeMutablePointer<Int>
    
    basePtr.pointee // 1
    basePtr.pointee = 10
    basePtr.pointee // 10
    
    //下一个元素
    var nextPtr = basePtr.successor()
    nextPtr.pointee // 2
}
do {
    //如果我们想对某个变量进行指针操作，我们可以借助 withUnsafePointer 这个辅助方法。这个方法接受两个参数，第一个是 inout 的任意类型，第二个是一个闭包。Swift 会将第一个输入转换为指针，然后将这个转换后的 Unsafe 的指针作为参数，去调用闭包。
    var test = 10
    test = withUnsafeMutablePointer(to: &test, { (ptr: UnsafeMutablePointer<Int>) -> Int in
        ptr.pointee += 1
        return ptr.pointee
    })
    
    test // 11
}
do {
    let arr = NSArray(object: "meow")
    let str = unsafeBitCast(CFArrayGetValueAtIndex(arr, 0), to: CFString.self)
    str // “meow”
}
do {
    /*
     关于 unsafeBitCast 一种更常见的使用场景是不同类型的指针之间进行转换。因为指针本身所占用的的大小是一定的，所以指针的类型进行转换是不会出什么致命问题的。这在与一些 C API 协作时会很常见。比如有很多 C API 要求的输入是 void *，对应到 Swift 中为 UnsafePointer<Void>。我们可以通过下面这样的方式将任意指针转换为 UnsafePointer。
 */
    var count = 100
    var voidPtr = withUnsafePointer(to: &count, { (a: UnsafePointer<Int>) -> UnsafeRawPointer in
        return unsafeBitCast(a, to: UnsafeRawPointer.self)
    })
    // voidPtr 是 UnsafePointer<Void>。相当于 C 中的 void *
    
    // 转换回 UnsafePointer<Int>
    var intPtr = unsafeBitCast(voidPtr, to: UnsafePointer<Int>.self)
    intPtr.pointee //100
}

//: [Next](@next)

