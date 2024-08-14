//
//  Skeleton.swift
//  BrainPower
//
//  Created by user on 8/13/24.
//

import ARKit
import RealityKit

class Skeleton: Entity {
    var joints: [JointType: Entity] = [:]
    var bones: [BoneType: Entity] = [:]

    required init(for bodyAnchor: ARBodyAnchor) {
        super.init()
        setup(for: bodyAnchor)
    }

    required init() {
        fatalError("init() has not been implemented.")
    }

    private func setup(for bodyAnchor: ARBodyAnchor) {
        let rootPosition = simd_make_float3(bodyAnchor.transform.columns.3)
        joints = Dictionary(
            uniqueKeysWithValues: JointType.allCases.map { [weak self] jointType in
                let mesh = MeshResource.generateSphere(radius: jointType.radius)
                let material = SimpleMaterial(color: jointType.color, roughness: 0.37, isMetallic: true)
                let entity = ModelEntity(mesh: mesh, materials: [material])
                self?.addChild(entity)
                return (jointType, entity)
            }
        )

        bones = Dictionary(
            uniqueKeysWithValues: BoneType.allCases.compactMap { [weak self] boneType in
                guard let from = bodyAnchor.skeleton.modelTransform(for: boneType.from.arSkeletonJointName),
                      let to = bodyAnchor.skeleton.modelTransform(for: boneType.to.arSkeletonJointName) else {
                    return nil
                }
                let fromPosition = from.position + rootPosition
                let toPosition = to.position + rootPosition
                let mesh = MeshResource.generateBox(
                    size: [boneType.thickness, boneType.thickness, simd_distance(fromPosition, toPosition)],
                    cornerRadius: boneType.thickness / 2.0
                )
                let material = SimpleMaterial(color: .white, roughness: 0.47, isMetallic: false)
                let entity = ModelEntity(mesh: mesh, materials: [material])
                let centerPosition = fromPosition.centerPoint(to: toPosition)
                entity.position = centerPosition
                entity.look(at: toPosition, from: centerPosition, relativeTo: nil)
                self?.addChild(entity)
                return (boneType, entity)
            }
        )
    }

    func update(with bodyAnchor: ARBodyAnchor) {
        let rootPosition = simd_make_float3(bodyAnchor.transform.columns.3)

        for jointType in JointType.allCases {
            guard let jointEntity = joints[jointType],
                  let transform = bodyAnchor.skeleton.modelTransform(for: jointType.arSkeletonJointName) else {
                continue
            }
            jointEntity.position = transform.position + rootPosition
            jointEntity.orientation = Transform(matrix: transform).rotation
        }

        for boneType in BoneType.allCases {
            guard let boneEntity = bones[boneType],
                  let from = bodyAnchor.skeleton.modelTransform(for: boneType.from.arSkeletonJointName),
                  let to = bodyAnchor.skeleton.modelTransform(for: boneType.to.arSkeletonJointName) else {
                continue
            }
            let fromPosition = from.position + rootPosition
            let toPosition = to.position + rootPosition
            let centerPosition = fromPosition.centerPoint(to: toPosition)
            boneEntity.position = centerPosition
            boneEntity.look(at: toPosition, from: centerPosition, relativeTo: nil)
        }
    }
}

extension JointType {
    var arSkeletonJointName: ARSkeleton.JointName {
        ARSkeleton.JointName(rawValue: rawValue)
    }

    var radius: Float {
        switch self {
        case .neck1, .neck2, .neck3, .neck4, .head, .leftShoulder, .rightShoulder:
            return 0.02
        case .jaw, .chin, .leftEye, .leftEyeLowerLid, .leftEyeUpperLid, .leftEyeball, .nose, .rightEye, .rightEyeLowerLid, .rightEyeUpperLid, .rightEyeball:
            return 0.015
        case .spine1, .spine2, .spine3, .spine4, .spine5, .spine6, .spine7:
            return 0.03
        case .leftHand, .rightHand:
            return 0.04
        case .leftHandIndexStart, .leftHandIndex1, .leftHandIndex2, .leftHandIndex3, .leftHandIndexEnd,
                .leftHandMidStart, .leftHandMid1, .leftHandMid2, .leftHandMid3, .leftHandMidEnd,
                .leftHandPinkyStart, .leftHandPinky1, .leftHandPinky2, .leftHandPinky3, .leftHandPinkyEnd,
                .leftHandRingStart, .leftHandRing1, .leftHandRing2, .leftHandRing3, .leftHandRingEnd,
                .leftHandThumbStart, .leftHandThumb1, .leftHandThumb2, .leftHandThumbEnd,
                .rightHandIndexStart, .rightHandIndex1, .rightHandIndex2, .rightHandIndex3, .rightHandIndexEnd,
                .rightHandMidStart, .rightHandMid1, .rightHandMid2, .rightHandMid3, .rightHandMidEnd,
                .rightHandPinkyStart, .rightHandPinky1, .rightHandPinky2, .rightHandPinky3, .rightHandPinkyEnd,
                .rightHandRingStart, .rightHandRing1, .rightHandRing2, .rightHandRing3, .rightHandRingEnd,
                .rightHandThumbStart, .rightHandThumb1, .rightHandThumb2, .rightHandThumbEnd:
            return 0.01
        case .leftToes, .leftToesEnd, .rightToes, .rightToesEnd:
            return 0.02
        default:
            return 0.05
        }
    }

    var color: UIColor {
        switch self {
        case .jaw, .chin, .leftEye, .leftEyeLowerLid, .leftEyeUpperLid, .leftEyeball, .nose, .rightEye, .rightEyeLowerLid, .rightEyeUpperLid, .rightEyeball,
             .leftHandIndexStart, .leftHandIndex1, .leftHandIndex2, .leftHandIndex3, .leftHandIndexEnd,
             .leftHandMidStart, .leftHandMid1, .leftHandMid2, .leftHandMid3, .leftHandMidEnd,
             .leftHandPinkyStart, .leftHandPinky1, .leftHandPinky2, .leftHandPinky3, .leftHandPinkyEnd,
             .leftHandRingStart, .leftHandRing1, .leftHandRing2, .leftHandRing3, .leftHandRingEnd,
             .leftHandThumbStart, .leftHandThumb1, .leftHandThumb2, .leftHandThumbEnd,
             .rightHandIndexStart, .rightHandIndex1, .rightHandIndex2, .rightHandIndex3, .rightHandIndexEnd,
             .rightHandMidStart, .rightHandMid1, .rightHandMid2, .rightHandMid3, .rightHandMidEnd,
             .rightHandPinkyStart, .rightHandPinky1, .rightHandPinky2, .rightHandPinky3, .rightHandPinkyEnd,
             .rightHandRingStart, .rightHandRing1, .rightHandRing2, .rightHandRing3, .rightHandRingEnd,
             .rightHandThumbStart, .rightHandThumb1, .rightHandThumb2, .rightHandThumbEnd,
             .leftToes, .leftToesEnd, .rightToes, .rightToesEnd:
            return .yellow
        default:
            return .green
        }
    }
}

extension BoneType {
    var thickness: Float {
        switch self {
        case .spine1ToSpine2, .spine2ToSpine3, .spine3ToSpine4, .spine4ToSpine5, .spine5ToSpine6, .spine6ToSpine7:
            return 0.04
        case .hipsToLeftUpLeg, .hipsToRightUpLeg:
            return 0.04
        case .leftUpLegToLeftLeg, .rightUpLegToRightLeg, .leftLegToLeftFoot, .rightLegToRightFoot:
            return 0.03
        case .leftFootToLeftToes, .rightFootToRightToes, .leftToesToLeftToesEnd, .rightToesToRightToesEnd:
            return 0.02
        case .spine7ToLeftShoulder, .spine7ToRightShoulder:
            return 0.03
        case .leftShoulderToLeftArm, .rightShoulderToRightArm, .leftArmToLeftForearm, .rightArmToRightForearm:
            return 0.03
        case .leftForearmToLeftHand, .rightForearmToRightHand:
            return 0.03
        case .leftHandToLeftHandIndexStart, .rightHandToRightHandIndexStart,
             .leftHandIndexStartToLeftHandIndex1, .rightHandIndexStartToRightHandIndex1,
             .leftHandIndex1ToLeftHandIndex2, .rightHandIndex1ToRightHandIndex2,
             .leftHandIndex2ToLeftHandIndex3, .rightHandIndex2ToRightHandIndex3,
             .leftHandIndex3ToLeftHandIndexEnd, .rightHandIndex3ToRightHandIndexEnd,
             .leftHandToLeftHandMidStart, .rightHandToRightHandMidStart,
             .leftHandMidStartToLeftHandMid1, .rightHandMidStartToRightHandMid1,
             .leftHandMid1ToLeftHandMid2, .rightHandMid1ToRightHandMid2,
             .leftHandMid2ToLeftHandMid3, .rightHandMid2ToRightHandMid3,
             .leftHandMid3ToLeftHandMidEnd, .rightHandMid3ToRightHandMidEnd,
             .leftHandToLeftHandPinkyStart, .rightHandToRightHandPinkyStart,
             .leftHandPinkyStartToLeftHandPinky1, .rightHandPinkyStartToRightHandPinky1,
             .leftHandPinky1ToLeftHandPinky2, .rightHandPinky1ToRightHandPinky2,
             .leftHandPinky2ToLeftHandPinky3, .rightHandPinky2ToRightHandPinky3,
             .leftHandPinky3ToLeftHandPinkyEnd, .rightHandPinky3ToRightHandPinkyEnd,
             .leftHandToLeftHandRingStart, .rightHandToRightHandRingStart,
             .leftHandRingStartToLeftHandRing1, .rightHandRingStartToRightHandRing1,
             .leftHandRing1ToLeftHandRing2, .rightHandRing1ToRightHandRing2,
             .leftHandRing2ToLeftHandRing3, .rightHandRing2ToRightHandRing3,
             .leftHandRing3ToLeftHandRingEnd, .rightHandRing3ToRightHandRingEnd,
             .leftHandToLeftHandThumbStart, .rightHandToRightHandThumbStart,
             .leftHandThumbStartToLeftHandThumb1, .rightHandThumbStartToRightHandThumb1,
             .leftHandThumb1ToLeftHandThumb2, .rightHandThumb1ToRightHandThumb2,
             .leftHandThumb2ToLeftHandThumbEnd, .rightHandThumb2ToRightHandThumbEnd:
            return 0.01
        case .neck1ToNeck2, .neck2ToNeck3, .neck3ToNeck4, .neck4ToHead:
            return 0.02
        case .headToJaw, .jawToChin:
            return 0.02
        case .headToLeftEye, .headToRightEye, .leftEyeToLeftEyeLowerLid, .rightEyeToRightEyeLowerLid,
             .leftEyeToLeftEyeUpperLid, .rightEyeToRightEyeUpperLid, .leftEyeToLeftEyeball, .rightEyeToRightEyeball,
             .headToNose:
            return 0.02
        }
    }
}

extension simd_float4x4 {
    var position: simd_float3 {
        simd_make_float3(columns.3)
    }
}

extension simd_float3 {
    func centerPoint(to: simd_float3) -> simd_float3 {
        [
            (x + to.x) / 2.0,
            (y + to.y) / 2.0,
            (z + to.z) / 2.0
        ]
    }
}
