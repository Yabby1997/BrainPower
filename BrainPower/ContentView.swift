//
//  ContentView.swift
//  BrainPower
//
//  Created by user on 8/12/24.
//

import SwiftUI

struct ContentView: View {
    @State var debugString = "Debug"

    var body: some View {
        ZStack {
            ARViewWrapper(debugString: $debugString)
            Text(debugString)
                .font(.system(size: 10, weight: .bold, design: .monospaced))
                .foregroundStyle(.yellow)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
