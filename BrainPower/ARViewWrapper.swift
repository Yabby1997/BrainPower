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
        ARView(frame: .zero)
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
