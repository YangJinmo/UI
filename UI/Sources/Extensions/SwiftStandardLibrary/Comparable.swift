//
//  Comparable.swift
//  UI
//
//  Created by Jmy on 2023/02/07.
//

extension Comparable {
    func clamp(low: Self, high: Self) -> Self {
        if self > high {
            return high
        } else if self < low {
            return low
        }

        return self
    }
}
