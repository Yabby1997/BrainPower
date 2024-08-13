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
            uniqueKeysWithValues: JointType.allCases.map { jointType in
                (jointType, createJoint(radius: jointType.radius, color: jointType.color))
            }
        )

        joints.forEach { [weak self] _, entity in
            self?.addChild(entity)
        }

        bones = Dictionary(
            uniqueKeysWithValues: BoneType.allCases.compactMap { boneType in
                guard let fromTransform = bodyAnchor.skeleton.modelTransform(for: boneType.from.arSkeletonJointName),
                      let toTransform = bodyAnchor.skeleton.modelTransform(for: boneType.to.arSkeletonJointName) else {
                    return nil
                }
                return (
                    boneType,
                    createBoneEntity(
                        for: simd_distance(
                            simd_make_float3(fromTransform.columns.3) + rootPosition,
                            simd_make_float3(toTransform.columns.3) + rootPosition
                        )
                    )
                )
            }
        )

        bones.forEach { [weak self] _ , entity in
            self?.addChild(entity)
        }
    }

    func update(with bodyAnchor: ARBodyAnchor) {
        let rootPosition = simd_make_float3(bodyAnchor.transform.columns.3)

        for jointType in JointType.allCases {
            guard let jointEntity = joints[jointType],
                  let transform = bodyAnchor.skeleton.modelTransform(for: jointType.arSkeletonJointName) else {
                continue
            }
            jointEntity.position = simd_make_float3(transform.columns.3) + rootPosition
            jointEntity.orientation = Transform(matrix: transform).rotation
        }

        for boneType in BoneType.allCases {
            guard let boneEntity = bones[boneType],
                  let fromTransform = bodyAnchor.skeleton.modelTransform(for: boneType.from.arSkeletonJointName),
                  let toTransform = bodyAnchor.skeleton.modelTransform(for: boneType.to.arSkeletonJointName) else {
                continue
            }
            let fromPosition = simd_make_float3(fromTransform.columns.3) + rootPosition
            let toPosition = simd_make_float3(toTransform.columns.3) + rootPosition
            let center: SIMD3<Float> = [
                (fromPosition.x + toPosition.x) / 2.0,
                (fromPosition.y + toPosition.y) / 2.0,
                (fromPosition.z + toPosition.z) / 2.0
            ]
            boneEntity.position = center
            boneEntity.look(at: toPosition, from: center, relativeTo: nil)
        }
    }

    private func createJoint(radius: Float, color: UIColor = .white) -> Entity {
        let mesh = MeshResource.generateSphere(radius: radius)
        let material = SimpleMaterial(color: color, roughness: 0.37, isMetallic: true)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        return entity
    }

    private func createBoneEntity(for length: Float = .zero, diameter: Float = 0.04, color: UIColor = .white) -> Entity {
        let mesh = MeshResource.generateBox(size: [diameter, diameter, length], cornerRadius: diameter / 2)
        let material = SimpleMaterial(color: color, roughness: 0.47, isMetallic: false)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        return entity
    }
}

extension JointType {
    var arSkeletonJointName: ARSkeleton.JointName {
        ARSkeleton.JointName(rawValue: rawValue)
    }

    var radius: Float {
        switch self {
        case .neck1, .neck2, .neck3, .neck4, .head, .leftShoulder, .rightShoulder:
            return 0.05 * 0.37
        case .jaw, .chin, .leftEye, .leftEyeLowerLid, .leftEyeUpperLid, .leftEyeball, .nose, .rightEye, .rightEyeLowerLid, .rightEyeUpperLid, .rightEyeball:
            return 0.05 * 0.17
        case .spine1, .spine2, .spine3, .spine4, .spine5, .spine6, .spine7:
            return 0.05 * 0.57
        case .leftHand, .rightHand:
            return 0.05 * 0.87
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
            return 0.05 * 0.17
        case .leftToes, .leftToesEnd, .rightToes, .rightToesEnd:
            return 0.05 * 0.37
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
