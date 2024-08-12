//
//  ARViewWrapper.swift
//  BrainPower
//
//  Created by user on 8/12/24.
//

import ARKit
import RealityKit
import SwiftUI

struct ARViewWrapper: UIViewRepresentable {
    func updateUIView(_ uiView: ARView, context: Context) {}

    func makeUIView(context: Context) -> ARView {
        let view = ARView(frame: .zero)
        let bodyTrackingConfiguration = ARBodyTrackingConfiguration()
        view.session.run(bodyTrackingConfiguration)
        view.session.delegate = context.coordinator
        view.scene.addAnchor(context.coordinator.bodyTrackingAnchor)
        return view
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, ARSessionDelegate {
        var skeleton: Skeleton?
        let bodyTrackingAnchor: AnchorEntity = AnchorEntity()

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
