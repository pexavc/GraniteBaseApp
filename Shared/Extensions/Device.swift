//
//  Device.swift
//  
//
//  Created by Ritesh Pakala on 7/5/23.
//

import Foundation

struct Device {
    static var isMacOS: Bool {
        #if os(macOS)
        return true
        #else
        return false
        #endif
    }
}
