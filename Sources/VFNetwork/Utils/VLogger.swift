//
//  VLogger.swift
//  VFNetwork
//
//  Created by Victor Freitas on 31/01/22.
//

import Foundation

class VLogger {
    
    var logText: String = ""
    
    /**
     Method for log items in console.
     
     - Parameters:
         - items: VLoggerFunctions...
     
     - Returns:
           Void
     */
    func log(_ items: VLoggerFunctions...) {
        build(items.map { $0 })
        print(logText)
    }
    
    // MARK: Build Method
    
    /**
     Method for build items for print in console.
     
     - Parameters:
         - items: VLoggerFunctions...
     
     - Returns:
           Void
     */
    func build(_ items: [VLoggerFunctions]) {
        items.forEach { item in
            switch item {
            case let .inline(icon, key, value):
                add(icon: icon, key: key, value: value)
            case let .multline(icon, title, values):
                add(icon: icon, title: title, values: values)
            case .breakLine:
                breakLine()
            case let .breakLines(quantity):
                breakLine(quantity: quantity)
            case let .vIf(isTrue, completion, elseCompletion):
                if isTrue {
                    build(completion())
                } else {
                    build(elseCompletion?() ?? [])
                }
            }
        }
    }
     
    /**
     Method for add item on log text.
     
     - Parameters:
         - icon: VLoggerIcon
         - key: String
         - value: String?
     
     - Returns:
           Void
     */
    func add(icon: VLoggerIcon = .none, key: String, value: String?) {
        if icon != .none {
            logText += "\n  \(icon.rawValue) \(key) \(value ?? "")"
        } else {
            logText += "\n\(icon.rawValue) \(key) \(value ?? "")"
        }
        
    }
    
    /**
     Method for add item with values on log text.
     
     - Parameters:
         - icon: VLoggerIcon
         - title: String
         - values: [String: String]
     
     - Returns:
           Void
     */
    func add(icon: VLoggerIcon = .none, title: String, values: [String: String]) {
        if icon != .none {
            logText += "\n  \(icon.rawValue) \(title) \n"
        } else {
            logText += "\n\(icon.rawValue) \(title) \n"
        }
        
        values.forEach { key, value in
            logText += "      \(key): \(value) \n"
        }
    }
    
    /**
     Method for break lines on log text.
     
     - Parameters:
         - quantity: Int64
     
     - Returns:
           Void
     */
    func breakLine(quantity: Int64 = 1) {
        for _ in 1...quantity {
            logText += "\n"
        }
    }
    
    /**
     Method for clear log text.
     
     - Returns:
           Void
     */
    func clear() {
        logText = ""
    }
}

// MARK: Enums

enum VLoggerFunctions {
    case inline(icon: VLoggerIcon = .none, key: String, value: String? = nil)
    case multline(icon: VLoggerIcon = .none, title: String, values: [String: String])
    case breakLine
    case breakLines(Int64)
    case vIf(Bool, (() -> [VLoggerFunctions]), `vElse`: (() -> [VLoggerFunctions])? = nil)
}

enum VLoggerIcon: String, RawRepresentable {
    case success = "✅"
    case failure = "❌"
    case cached = "💾"
    case request = "🚀"
    case host = "🌎"
    case url = "🎯"
    case secure = "🛡"
    case body = "📨"
    case none = ""
}
