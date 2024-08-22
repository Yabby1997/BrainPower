//
//  ContentView.swift
//  BrainPower
//
//  Created by user on 8/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = GameViewModel()

    var body: some View {
        ZStack {
            GameView(viewModel: viewModel)
            Text(viewModel.debugString)
                .font(.system(size: 10, weight: .bold, design: .monospaced))
                .foregroundStyle(.yellow)
        }
        .ignoresSafeArea()
    }
}
