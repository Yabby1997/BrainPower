//
//  BrainPower.swift
//  BrainPower
//
//  Created by user on 8/23/24.
//
import ARKit
import RealityKit
import Combine
import Foundation

class BrainPower: NSObject {
    private var character: BodyTrackedEntity?
    private let characterAnchor = AnchorEntity()
    private var gamePlaneAnchor: AnchorEntity?
    private var gamePlane: ModelEntity?
    private var isGamePlaneFixed = false
    private var debugStringSubject = CurrentValueSubject<String, Never>("")
    private weak var scene: RealityKit.Scene?
    private var cancellables: Set<AnyCancellable> = []

    let debugString: AnyPublisher<String, Never>

    /// Session for game.
    let session: ARSession = {
        let config = ARBodyTrackingConfiguration()
        config.planeDetection = .horizontal
        let session = ARSession()
        session.run(config)
        return session
    }()

    override init() {
        debugString = debugStringSubject.eraseToAnyPublisher()
        super.init()
        session.delegate = self
    }

    func setup(scene: Scene) {
        self.scene = scene
        scene.addAnchor(characterAnchor)

        scene.subscribe(to: CollisionEvents.Began.self) { [weak self] event in
            self?.debugStringSubject.send("\(event.entityA.name) just collide with \(event.entityB.name)")
        }
        .store(in: &cancellables)

        Entity.loadBodyTrackedAsync(named: "robot")
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("character model loaded successfully.")
                    case let .failure(error):
                        print("failed to load character model due to an error: \(error.localizedDescription)")
                    }
                },
                receiveValue: { [weak self] character in
                    character.scale = [1, 1, 1]
                    self?.character = character
                }
            )
            .store(in: &cancellables)
    }

    func startGame() {
        guard let gamePlane, !isGamePlaneFixed else { return }
        isGamePlaneFixed = true

        let wallEntity = ModelEntity(
            mesh: .generateBox(width: 2, height: 2, depth: 0.3),
            materials: [SimpleMaterial(color: .red, isMetallic: true)]
        )
        wallEntity.collision = .init(
            shapes: [.generateBox(width: 1, height: 1, depth: 0.2)],
            filter: .init(
                group: .wall,
                mask: .all.subtracting(.wall)
            )
        )
        wallEntity.name = "Red Wall"
        wallEntity.position = SIMD3<Float>(0, 1, -4.9)
        gamePlane.addChild(wallEntity)

        let endPosition = SIMD3<Float>(0, 1, 4.9)
        let duration: TimeInterval = 10.0

        var transform = wallEntity.transform
        transform.translation = endPosition

        wallEntity.move(to: transform, relativeTo: wallEntity.parent, duration: duration, timingFunction: .linear)
    }

    func translate(_ translation: CGPoint) {
        guard !isGamePlaneFixed, let gamePlaneAnchor else { return }
        let xTranslation = Float(translation.x) / 1000.0
        let zTranslation = Float(translation.y) / 1000.0
        gamePlaneAnchor.position.x += xTranslation
        gamePlaneAnchor.position.z += zTranslation
    }

    func rotate(_ rotation: Float) {
        guard !isGamePlaneFixed, let gamePlaneAnchor else { return }
        gamePlaneAnchor.transform.rotation *= simd_quatf(angle: rotation, axis: SIMD3<Float>(0, 1, 0))
    }
}

extension BrainPower: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchor = anchor as? ARPlaneAnchor {
                guard gamePlane == nil else { return }
                let gamePlaneAnchor = AnchorEntity(anchor: anchor)
                let gamePlane = ModelEntity(
                    mesh: .generateBox(width: 2, height: 0.1, depth: 10),
                    materials: [SimpleMaterial(color: .yellow.withAlphaComponent(0.5), isMetallic: false)]
                )
                gamePlane.name = "Game Plane"
                gamePlane.position = simd_float3(x: .zero, y: .zero, z: -3)
                gamePlaneAnchor.addChild(gamePlane)
                scene?.addAnchor(gamePlaneAnchor)
                self.gamePlane = gamePlane
                self.gamePlaneAnchor = gamePlaneAnchor
            }
        }
    }

    public func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            if let bodyAnchor = anchor as? ARBodyAnchor {
                characterAnchor.position = simd_make_float3(bodyAnchor.transform.columns.3)
                characterAnchor.orientation = Transform(matrix: bodyAnchor.transform).rotation
                if let character, character.parent == nil {
                    characterAnchor.addChild(character)
                    print("character added on anchor")
                }
            }
        }
    }
}
