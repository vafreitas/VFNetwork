//
//  CustomSubject.swift
//  VFNetwork
//
//  Created by Victor Alves de Freitas on 23/12/22.
//

import Foundation

public enum ObservedType {
    case unauthorized
}

public protocol Observer: AnyObject {}

public protocol NetworkObserver: Observer {
    func didUnauthorized(action: Action)
}

/// Wrapper class that will hold the weak value of subscribers else VCs are gonna be retained
/// since they will be stored inside array that lives in Subject singleton object (that is alive through whole application lifecycle)
public class WeakObserver {
    weak var value: Observer?
    var types: Set<ObservedType>
    
    init(value: Observer?, subscribedFor types: [ObservedType]) {
        self.value = value
        self.types = Set(types)
    }
}

public protocol SubjectProtocol: AnyObject {
    func subscribe(_ observer: Observer, for types: ObservedType...)
    func unsubscribe(_ observer: Observer, from type: ObservedType)
    func unsubscribe(_ observer: Observer)
    func unsubscribeReleasedObservers() // Used for unsubscribing all observers that are nil
}

public class VFSubject: SubjectProtocol {
    
    public static let shared = VFSubject()
    
    private init() { }
    
    private var observers: [WeakObserver] = []
    
    public func subscribe(_ observer: Observer, for types: ObservedType...) {
        let existingObserverIndex = observers.firstIndex(where: { $0.value === observer })
        
        if let index = existingObserverIndex {
            types.forEach({ observers[index].types.insert($0) })
        } else {
            observers.append(WeakObserver(value: observer, subscribedFor: types))
        }
        print("Number of subscribers: \(observers.count)")
    }
    
    public func unsubscribe(_ observer: Observer, from type: ObservedType) {
        guard let index = observers.firstIndex(where: { $0.value === observer }) else { return } // Address comparison
        observers[index].types.remove(type)
        print("Number of subscribers: \(observers.count)")
    }
    
    public func unsubscribe(_ observer: Observer) {
        observers = observers.filter({ $0.value !== observer })
        print("Number of subscribers: \(observers.count)")
    }
    
    // This method has to be called manually on deinit of some observer object
    public func unsubscribeReleasedObservers() {
        observers = observers.filter({ $0.value != nil })
        print("Number of subscribers: \(observers.count)")
    }
}

extension VFSubject {
    public func publish(_ action: Action) {
        observers
            .filter { $0.types.contains(.unauthorized) }
            .forEach { (observer) in
                guard let observer = observer.value as? NetworkObserver else { return }
                observer.didUnauthorized(action: action)
            }
    }
}

public enum Action {
    case update
}
