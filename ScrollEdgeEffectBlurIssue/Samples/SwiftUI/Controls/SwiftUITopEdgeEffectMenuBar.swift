//
//  SwiftUITopEdgeEffectMenuBar.swift
//  ScrollEdgeEffectBlurIssue
//
//  Created by Saeed Taheri on 2026/6/11.
//

import SwiftUI

struct SwiftUITopEdgeEffectMenuBar: View {
    @Binding var selection: EdgeEffectChoice

    var body: some View {
        HStack {
            Spacer()
            SwiftUIEdgeEffectMenu(selection: $selection)
        }
        .padding(16)
    }
}
