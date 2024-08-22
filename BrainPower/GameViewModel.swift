//
//  GameViewModel.swift
//  BrainPower
//
//  Created by user on 8/23/24.
//

import ARKit
import Foundation
import RealityKit

@MainActor
final class GameViewModel: ObservableObject {
    private let brainPower = BrainPower()
    @Published var debugString: String = "Debug"

    /// Session for game.
    var session: ARSession { brainPower.session }

    init() {
        bind()
    }

    private func bind() {
        brainPower.debugString
            .assign(to: &$debugString)
    }

    /// Call this method to provide `Scene` so that game can update graphical elements using it.
    func didSetup(scene: RealityKit.Scene) {
        brainPower.setup(scene: scene)
    }

    func didTap() {
        brainPower.startGame()
    }

    func didRotate(rotation: Float) {
        brainPower.rotate(rotation)
    }

    func didPan(translation: CGPoint) {
        brainPower.translate(translation)
    }
}
