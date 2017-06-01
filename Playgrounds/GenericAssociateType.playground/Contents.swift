//: Playground - noun: a place where people can play

import UIKit

public protocol InjectionResultProtocol {
    associatedtype T
    var value: T { get }
}
class InjectionResultAdopter<U>: InjectionResultProtocol   {
    typealias T = U  //to say same type as Generic
    public var value: U
    init(value: U) {
        self.value = value
    }
}
class InjectionCenterAdopting {
    var recording: Bool = false
    func process<T>() -> InjectionResultAdopter<T>? {
        if let variable = recording as? T {  //type checking
            return InjectionResultAdopter<T>(value: variable)
        } else {
            return nil
        }
    }
}
//must declear  type for res other wise cannot infer what type process will return
let res: InjectionResultAdopter<Bool>? = InjectionCenterAdopting().process()
res?.value







