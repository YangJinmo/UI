//
//  BuildConfiguration.swift
//  UI
//
//  Created by Jmy on 2022/07/21.
//

func debug(_ block: () -> Void) {
    #if DEBUG
        block()
    #endif
}

func release(_ block: () -> Void) {
    #if !DEBUG
        block()
    #endif
}

var isDebug: Bool {
    #if DEBUG
        return true
    #else
        return false
    #endif
}
