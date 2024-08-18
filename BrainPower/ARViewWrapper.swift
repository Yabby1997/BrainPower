//
//  ARViewWrapper.swift
//  BrainPower
//
//  Created by user on 8/12/24.
//

import ARKit
import RealityKit
import SwiftUI
import Combine

struct ARViewWrapper: UIViewRepresentable {
    @Binding var debugString: String

    func updateUIView(_ uiView: ARView, context: Context) {}

    func makeUIView(context: Context) -> ARView {
        let view = ARView(frame: .zero)
        context.coordinator.view = view

        let bodyTrackingConfiguration = ARBodyTrackingConfiguration()
        bodyTrackingConfiguration.planeDetection = .horizontal
        view.session.run(bodyTrackingConfiguration)
        view.session.delegate = context.coordinator
        view.scene.addAnchor(context.coordinator.bodyTrackingAnchor)

        let wallAnchor = AnchorEntity()
        let wallEntity = ModelEntity(
            mesh: .generateBox(width: 1, height: 1, depth: 0.2, cornerRadius: 0.1),
            materials: [
                SimpleMaterial(color: .red, isMetallic: false)
            ]
        )
        wallEntity.collision = .init(
            shapes: [.generateBox(width: 1, height: 1, depth: 0.2)],
            filter: .init(
                group: .wall,
                mask: .all.subtracting(.wall)
            )
        )
        wallEntity.name = "Red Wall"
        wallAnchor.addChild(wallEntity)
        view.scene.addAnchor(wallAnchor)
        return view
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(debugString: $debugString)
    }

    class Coordinator: NSObject, ARSessionDelegate {
        @Binding var debugString: String
        var skeleton: Skeleton?
        let bodyTrackingAnchor = AnchorEntity()
        weak var view: ARView? {
            didSet { setupCollisions() }
        }

        private var cancellables: Set<AnyCancellable> = []

        var textAnchor: AnchorEntity?

        init(debugString: Binding<String>) {
            self._debugString = debugString
        }

        func setupCollisions() {
            guard let view else { return }
            
            view.scene.subscribe(to: CollisionEvents.Began.self) { [weak self] event in
                self?.debugString = "\(event.entityA.name) just collide with \(event.entityB.name)"
            }
            .store(in: &cancellables)
        }

        public func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            anchors.compactMap { $0 as? ARBodyAnchor }.forEach { [weak self] bodyAnchor in
                guard let self else { return }
                if let skeleton {
                    skeleton.update(with: bodyAnchor)
                } else {
                    let skeleton = Skeleton(for: bodyAnchor)
                    bodyTrackingAnchor.addChild(skeleton)
                    self.skeleton = skeleton
                }
            }
        }
    }
}
