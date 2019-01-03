
import Foundation

typealias ItemClosure<T> = ((T) -> Void)
typealias VoidClosure = (() -> Void)
typealias OptionalItemClosure<T> = ((T?) -> Void)
typealias ResultHandler<Value> = (RegisterResult<Value>) -> Void

