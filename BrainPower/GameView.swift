import ARKit
import RealityKit
import SwiftUI
import Combine

struct GameView: UIViewRepresentable {
    var viewModel: GameViewModel

    func makeUIView(context: Context) -> ARView {
        let view = ARView(frame: .zero)
        view.debugOptions = [.showSceneUnderstanding]
        view.session = viewModel.session
        viewModel.didSetup(scene: view.scene)

        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(context.coordinator.handleTapGesture(_:))
            )
        )

        view.addGestureRecognizer(
            UIPanGestureRecognizer(
                target: context.coordinator,
                action: #selector(context.coordinator.handlePanGesture(_:))
            )
        )

        view.addGestureRecognizer(
            UIRotationGestureRecognizer(
                target: context.coordinator,
                action: #selector(context.coordinator.handleRotationGesture(_:))
            )
        )

        return view
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

    @MainActor
    class Coordinator: NSObject, ARSessionDelegate {
        var viewModel: GameViewModel

        init(viewModel: GameViewModel) {
            self.viewModel = viewModel
        }

        @objc func handleTapGesture(_ gesture: UITapGestureRecognizer) {
            viewModel.didTap()
        }

        @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
            viewModel.didPan(translation: gesture.translation(in: gesture.view))
            gesture.setTranslation(.zero, in: gesture.view)
        }

        @objc func handleRotationGesture(_ gesture: UIRotationGestureRecognizer) {
            viewModel.didRotate(rotation: Float(gesture.rotation))
            gesture.rotation = 0
        }
    }
}
