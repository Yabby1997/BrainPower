//
//  BoneType.swift
//  BrainPower
//
//  Created by user on 8/13/24.
//

import Foundation

enum BoneType: CaseIterable {
    case spine1ToSpine2
    case spine2ToSpine3
    case spine3ToSpine4
    case spine4ToSpine5
    case spine5ToSpine6
    case spine6ToSpine7
    case hipsToLeftUpLeg
    case leftUpLegToLeftLeg
    case leftLegToLeftFoot
    case leftFootToLeftToes
    case leftToesToLeftToesEnd
    case hipsToRightUpLeg
    case rightUpLegToRightLeg
    case rightLegToRightFoot
    case rightFootToRightToes
    case rightToesToRightToesEnd
    case spine7ToLeftShoulder
    case leftShoulderToLeftArm
    case leftArmToLeftForearm
    case leftForearmToLeftHand
    case leftHandToLeftHandIndexStart
    case leftHandIndexStartToLeftHandIndex1
    case leftHandIndex1ToLeftHandIndex2
    case leftHandIndex2ToLeftHandIndex3
    case leftHandIndex3ToLeftHandIndexEnd
    case leftHandToLeftHandMidStart
    case leftHandMidStartToLeftHandMid1
    case leftHandMid1ToLeftHandMid2
    case leftHandMid2ToLeftHandMid3
    case leftHandMid3ToLeftHandMidEnd
    case leftHandToLeftHandPinkyStart
    case leftHandPinkyStartToLeftHandPinky1
    case leftHandPinky1ToLeftHandPinky2
    case leftHandPinky2ToLeftHandPinky3
    case leftHandPinky3ToLeftHandPinkyEnd
    case leftHandToLeftHandRingStart
    case leftHandRingStartToLeftHandRing1
    case leftHandRing1ToLeftHandRing2
    case leftHandRing2ToLeftHandRing3
    case leftHandRing3ToLeftHandRingEnd
    case leftHandToLeftHandThumbStart
    case leftHandThumbStartToLeftHandThumb1
    case leftHandThumb1ToLeftHandThumb2
    case leftHandThumb2ToLeftHandThumbEnd
    case spine7ToRightShoulder
    case rightShoulderToRightArm
    case rightArmToRightForearm
    case rightForearmToRightHand
    case rightHandToRightHandIndexStart
    case rightHandIndexStartToRightHandIndex1
    case rightHandIndex1ToRightHandIndex2
    case rightHandIndex2ToRightHandIndex3
    case rightHandIndex3ToRightHandIndexEnd
    case rightHandToRightHandMidStart
    case rightHandMidStartToRightHandMid1
    case rightHandMid1ToRightHandMid2
    case rightHandMid2ToRightHandMid3
    case rightHandMid3ToRightHandMidEnd
    case rightHandToRightHandPinkyStart
    case rightHandPinkyStartToRightHandPinky1
    case rightHandPinky1ToRightHandPinky2
    case rightHandPinky2ToRightHandPinky3
    case rightHandPinky3ToRightHandPinkyEnd
    case rightHandToRightHandRingStart
    case rightHandRingStartToRightHandRing1
    case rightHandRing1ToRightHandRing2
    case rightHandRing2ToRightHandRing3
    case rightHandRing3ToRightHandRingEnd
    case rightHandToRightHandThumbStart
    case rightHandThumbStartToRightHandThumb1
    case rightHandThumb1ToRightHandThumb2
    case rightHandThumb2ToRightHandThumbEnd
    case neck1ToNeck2
    case neck2ToNeck3
    case neck3ToNeck4
    case neck4ToHead
    case headToJaw
    case jawToChin
    case headToLeftEye
    case leftEyeToLeftEyeLowerLid
    case leftEyeToLeftEyeUpperLid
    case leftEyeToLeftEyeball
    case headToNose
    case headToRightEye
    case rightEyeToRightEyeLowerLid
    case rightEyeToRightEyeUpperLid
    case rightEyeToRightEyeball

    var from: JointType {
        switch self {
        case .spine1ToSpine2: return .spine1
        case .spine2ToSpine3: return .spine2
        case .spine3ToSpine4: return .spine3
        case .spine4ToSpine5: return .spine4
        case .spine5ToSpine6: return .spine5
        case .spine6ToSpine7: return .spine6
        case .hipsToLeftUpLeg: return .hips
        case .leftUpLegToLeftLeg: return .leftUpLeg
        case .leftLegToLeftFoot: return .leftLeg
        case .leftFootToLeftToes: return .leftFoot
        case .leftToesToLeftToesEnd: return .leftToes
        case .hipsToRightUpLeg: return .hips
        case .rightUpLegToRightLeg: return .rightUpLeg
        case .rightLegToRightFoot: return .rightLeg
        case .rightFootToRightToes: return .rightFoot
        case .rightToesToRightToesEnd: return .rightToes
        case .spine7ToLeftShoulder: return .spine7
        case .leftShoulderToLeftArm: return .leftShoulder
        case .leftArmToLeftForearm: return .leftArm
        case .leftForearmToLeftHand: return .leftForearm
        case .leftHandToLeftHandIndexStart: return .leftHand
        case .leftHandIndexStartToLeftHandIndex1: return .leftHandIndexStart
        case .leftHandIndex1ToLeftHandIndex2: return .leftHandIndex1
        case .leftHandIndex2ToLeftHandIndex3: return .leftHandIndex2
        case .leftHandIndex3ToLeftHandIndexEnd: return .leftHandIndex3
        case .leftHandToLeftHandMidStart: return .leftHand
        case .leftHandMidStartToLeftHandMid1: return .leftHandMidStart
        case .leftHandMid1ToLeftHandMid2: return .leftHandMid1
        case .leftHandMid2ToLeftHandMid3: return .leftHandMid2
        case .leftHandMid3ToLeftHandMidEnd: return .leftHandMid3
        case .leftHandToLeftHandPinkyStart: return .leftHand
        case .leftHandPinkyStartToLeftHandPinky1: return .leftHandPinkyStart
        case .leftHandPinky1ToLeftHandPinky2: return .leftHandPinky1
        case .leftHandPinky2ToLeftHandPinky3: return .leftHandPinky2
        case .leftHandPinky3ToLeftHandPinkyEnd: return .leftHandPinky3
        case .leftHandToLeftHandRingStart: return .leftHand
        case .leftHandRingStartToLeftHandRing1: return .leftHandRingStart
        case .leftHandRing1ToLeftHandRing2: return .leftHandRing1
        case .leftHandRing2ToLeftHandRing3: return .leftHandRing2
        case .leftHandRing3ToLeftHandRingEnd: return .leftHandRing3
        case .leftHandToLeftHandThumbStart: return .leftHand
        case .leftHandThumbStartToLeftHandThumb1: return .leftHandThumbStart
        case .leftHandThumb1ToLeftHandThumb2: return .leftHandThumb1
        case .leftHandThumb2ToLeftHandThumbEnd: return .leftHandThumb2
        case .spine7ToRightShoulder: return .spine7
        case .rightShoulderToRightArm: return .rightShoulder
        case .rightArmToRightForearm: return .rightArm
        case .rightForearmToRightHand: return .rightForearm
        case .rightHandToRightHandIndexStart: return .rightHand
        case .rightHandIndexStartToRightHandIndex1: return .rightHandIndexStart
        case .rightHandIndex1ToRightHandIndex2: return .rightHandIndex1
        case .rightHandIndex2ToRightHandIndex3: return .rightHandIndex2
        case .rightHandIndex3ToRightHandIndexEnd: return .rightHandIndex3
        case .rightHandToRightHandMidStart: return .rightHand
        case .rightHandMidStartToRightHandMid1: return .rightHandMidStart
        case .rightHandMid1ToRightHandMid2: return .rightHandMid1
        case .rightHandMid2ToRightHandMid3: return .rightHandMid2
        case .rightHandMid3ToRightHandMidEnd: return .rightHandMid3
        case .rightHandToRightHandPinkyStart: return .rightHand
        case .rightHandPinkyStartToRightHandPinky1: return .rightHandPinkyStart
        case .rightHandPinky1ToRightHandPinky2: return .rightHandPinky1
        case .rightHandPinky2ToRightHandPinky3: return .rightHandPinky2
        case .rightHandPinky3ToRightHandPinkyEnd: return .rightHandPinky3
        case .rightHandToRightHandRingStart: return .rightHand
        case .rightHandRingStartToRightHandRing1: return .rightHandRingStart
        case .rightHandRing1ToRightHandRing2: return .rightHandRing1
        case .rightHandRing2ToRightHandRing3: return .rightHandRing2
        case .rightHandRing3ToRightHandRingEnd: return .rightHandRing3
        case .rightHandToRightHandThumbStart: return .rightHand
        case .rightHandThumbStartToRightHandThumb1: return .rightHandThumbStart
        case .rightHandThumb1ToRightHandThumb2: return .rightHandThumb1
        case .rightHandThumb2ToRightHandThumbEnd: return .rightHandThumb2
        case .neck1ToNeck2: return .neck1
        case .neck2ToNeck3: return .neck2
        case .neck3ToNeck4: return .neck3
        case .neck4ToHead: return .neck4
        case .headToJaw: return .head
        case .jawToChin: return .jaw
        case .headToLeftEye: return .head
        case .leftEyeToLeftEyeLowerLid: return .leftEye
        case .leftEyeToLeftEyeUpperLid: return .leftEye
        case .leftEyeToLeftEyeball: return .leftEye
        case .headToNose: return .head
        case .headToRightEye: return .head
        case .rightEyeToRightEyeLowerLid: return .rightEye
        case .rightEyeToRightEyeUpperLid: return .rightEye
        case .rightEyeToRightEyeball: return .rightEye
        }
    }

    var to: JointType {
        switch self {
        case .spine1ToSpine2: return .spine2
        case .spine2ToSpine3: return .spine3
        case .spine3ToSpine4: return .spine4
        case .spine4ToSpine5: return .spine5
        case .spine5ToSpine6: return .spine6
        case .spine6ToSpine7: return .spine7
        case .hipsToLeftUpLeg: return .leftUpLeg
        case .leftUpLegToLeftLeg: return .leftLeg
        case .leftLegToLeftFoot: return .leftFoot
        case .leftFootToLeftToes: return .leftToes
        case .leftToesToLeftToesEnd: return .leftToesEnd
        case .hipsToRightUpLeg: return .rightUpLeg
        case .rightUpLegToRightLeg: return .rightLeg
        case .rightLegToRightFoot: return .rightFoot
        case .rightFootToRightToes: return .rightToes
        case .rightToesToRightToesEnd: return .rightToesEnd
        case .spine7ToLeftShoulder: return .leftShoulder
        case .leftShoulderToLeftArm: return .leftArm
        case .leftArmToLeftForearm: return .leftForearm
        case .leftForearmToLeftHand: return .leftHand
        case .leftHandToLeftHandIndexStart: return .leftHandIndexStart
        case .leftHandIndexStartToLeftHandIndex1: return .leftHandIndex1
        case .leftHandIndex1ToLeftHandIndex2: return .leftHandIndex2
        case .leftHandIndex2ToLeftHandIndex3: return .leftHandIndex3
        case .leftHandIndex3ToLeftHandIndexEnd: return .leftHandIndexEnd
        case .leftHandToLeftHandMidStart: return .leftHandMidStart
        case .leftHandMidStartToLeftHandMid1: return .leftHandMid1
        case .leftHandMid1ToLeftHandMid2: return .leftHandMid2
        case .leftHandMid2ToLeftHandMid3: return .leftHandMid3
        case .leftHandMid3ToLeftHandMidEnd: return .leftHandMidEnd
        case .leftHandToLeftHandPinkyStart: return .leftHandPinkyStart
        case .leftHandPinkyStartToLeftHandPinky1: return .leftHandPinky1
        case .leftHandPinky1ToLeftHandPinky2: return .leftHandPinky2
        case .leftHandPinky2ToLeftHandPinky3: return .leftHandPinky3
        case .leftHandPinky3ToLeftHandPinkyEnd: return .leftHandPinkyEnd
        case .leftHandToLeftHandRingStart: return .leftHandRingStart
        case .leftHandRingStartToLeftHandRing1: return .leftHandRing1
        case .leftHandRing1ToLeftHandRing2: return .leftHandRing2
        case .leftHandRing2ToLeftHandRing3: return .leftHandRing3
        case .leftHandRing3ToLeftHandRingEnd: return .leftHandRingEnd
        case .leftHandToLeftHandThumbStart: return .leftHandThumbStart
        case .leftHandThumbStartToLeftHandThumb1: return .leftHandThumb1
        case .leftHandThumb1ToLeftHandThumb2: return .leftHandThumb2
        case .leftHandThumb2ToLeftHandThumbEnd: return .leftHandThumbEnd
        case .spine7ToRightShoulder: return .rightShoulder
        case .rightShoulderToRightArm: return .rightArm
        case .rightArmToRightForearm: return .rightForearm
        case .rightForearmToRightHand: return .rightHand
        case .rightHandToRightHandIndexStart: return .rightHandIndexStart
        case .rightHandIndexStartToRightHandIndex1: return .rightHandIndex1
        case .rightHandIndex1ToRightHandIndex2: return .rightHandIndex2
        case .rightHandIndex2ToRightHandIndex3: return .rightHandIndex3
        case .rightHandIndex3ToRightHandIndexEnd: return .rightHandIndexEnd
        case .rightHandToRightHandMidStart: return .rightHandMidStart
        case .rightHandMidStartToRightHandMid1: return .rightHandMid1
        case .rightHandMid1ToRightHandMid2: return .rightHandMid2
        case .rightHandMid2ToRightHandMid3: return .rightHandMid3
        case .rightHandMid3ToRightHandMidEnd: return .rightHandMidEnd
        case .rightHandToRightHandPinkyStart: return .rightHandPinkyStart
        case .rightHandPinkyStartToRightHandPinky1: return .rightHandPinky1
        case .rightHandPinky1ToRightHandPinky2: return .rightHandPinky2
        case .rightHandPinky2ToRightHandPinky3: return .rightHandPinky3
        case .rightHandPinky3ToRightHandPinkyEnd: return .rightHandPinkyEnd
        case .rightHandToRightHandRingStart: return .rightHandRingStart
        case .rightHandRingStartToRightHandRing1: return .rightHandRing1
        case .rightHandRing1ToRightHandRing2: return .rightHandRing2
        case .rightHandRing2ToRightHandRing3: return .rightHandRing3
        case .rightHandRing3ToRightHandRingEnd: return .rightHandRingEnd
        case .rightHandToRightHandThumbStart: return .rightHandThumbStart
        case .rightHandThumbStartToRightHandThumb1: return .rightHandThumb1
        case .rightHandThumb1ToRightHandThumb2: return .rightHandThumb2
        case .rightHandThumb2ToRightHandThumbEnd: return .rightHandThumbEnd
        case .neck1ToNeck2: return .neck2
        case .neck2ToNeck3: return .neck3
        case .neck3ToNeck4: return .neck4
        case .neck4ToHead: return .head
        case .headToJaw: return .jaw
        case .jawToChin: return .chin
        case .headToLeftEye: return .leftEye
        case .leftEyeToLeftEyeLowerLid: return .leftEyeLowerLid
        case .leftEyeToLeftEyeUpperLid: return .leftEyeUpperLid
        case .leftEyeToLeftEyeball: return .leftEyeball
        case .headToNose: return .nose
        case .headToRightEye: return .rightEye
        case .rightEyeToRightEyeLowerLid: return .rightEyeLowerLid
        case .rightEyeToRightEyeUpperLid: return .rightEyeUpperLid
        case .rightEyeToRightEyeball: return .rightEyeball
        }
    }
}
