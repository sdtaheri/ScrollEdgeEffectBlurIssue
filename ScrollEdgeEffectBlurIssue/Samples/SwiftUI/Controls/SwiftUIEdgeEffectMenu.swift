//
//  SwiftUIEdgeEffectMenu.swift
//  ScrollEdgeEffectBlurIssue
//
//  Created by Saeed Taheri on 2026/6/11.
//

import SwiftUI

struct SwiftUIEdgeEffectMenu: View {
    @Binding var selection: EdgeEffectChoice

    var body: some View {
        Menu {
            Section("Effect Style") {
                ForEach(EdgeEffectChoice.allCases, id: \.self) { choice in
                    Button {
                        selection = choice
                    } label: {
                        Label(choice.title, systemImage: choice.systemImage)
                    }
                }
            }
        } label: {
            Label("Effect Style: \(selection.title)", systemImage: "line.3.horizontal.decrease.circle")
                .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal, 14)
                .frame(height: 44)
                .background(.background, in: Capsule())
                .shadow(color: .black.opacity(0.24), radius: 12, x: 0, y: 6)
        }
        .accessibilityLabel("Effect Style: \(selection.title)")
    }
}
