//
//  CollisionGroup+Extensions.swift
//  BrainPower
//
//  Created by user on 8/18/24.
//

import RealityKit

extension CollisionGroup {
    static let wall: Self = .init(rawValue: 1 << 0)
    static let skeleton: Self = .init(rawValue: 1 << 1)
}
