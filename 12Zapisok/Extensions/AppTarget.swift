//
//  AppTarget.swift
//  12Zapisok
//
//  Created by Anton Makarov on 23.09.2020.
//  Copyright © 2020 A.Makarov. All rights reserved.
//
// swiftlint:disable all

import Foundation

enum AppTargetType {
    case main
    case swiftUI
}

struct AppTarget {
    
    static var type: AppTargetType {
        let bundleId = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
        var target: AppTargetType = .main
        
        if bundleId.contains("SwiftUI") {
            target = .swiftUI
        }

        return target
    }
    
    static var appDelegate: AnyClass {
        
        switch AppTarget.type {
        case .main:
            return AppDelegate.self
            
        case .swiftUI:
            return AppDelegate.self // SwiftUIAppDelegate.self
        }
    }
}
