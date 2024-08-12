//
//  ARViewWrapper.swift
//  BrainPower
//
//  Created by user on 8/12/24.
//

import RealityKit
import SwiftUI

struct ARViewWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = ARView(frame: .zero)
        let anchor = try! Experience.loadCube()
        view.scene.addAnchor(anchor)
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
