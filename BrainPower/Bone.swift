//
//  Bone.swift
//  BrainPower
//
//  Created by user on 8/13/24.
//

import Foundation
import simd

struct Bone {
    let from: Joint
    let to: Joint

    var center: SIMD3<Float> {
        [
            (from.position.x + to.position.x) / 2.0,
            (from.position.y + to.position.y) / 2.0,
            (from.position.z + to.position.z) / 2.0
        ]
    }

    var length: Float {
        simd_distance(from.position, to.position)
    }
}
