//
//  SwiftUIScrollSampleView.swift
//  ScrollEdgeEffectBlurIssue
//
//  Created by Saeed Taheri on 2026/6/11.
//

import SwiftUI

struct SwiftUIScrollSampleView: View {
    @State private var edgeEffectChoice: EdgeEffectChoice = .automatic
    private let items = SampleData.rows(prefix: "LazyVStack row")

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(items, id: \.self) { item in
                    HStack(spacing: 12) {
                        Image(systemName: "rectangle.stack")
                            .font(.title3)
                            .foregroundStyle(.tint)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item)
                                .font(.headline)
                            Text("ScrollView containing LazyVStack")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(16)
        }
        .scrollEdgeEffectStyle(edgeEffectChoice.swiftUIStyle, for: .all)
        .safeAreaBar(edge: .top, spacing: 0) {
            SwiftUITopEdgeEffectMenuBar(selection: $edgeEffectChoice)
        }
        .safeAreaBar(edge: .bottom, spacing: 0) {
            SwiftUIBottomFAB()
        }
    }
}

#Preview {
    SwiftUIScrollSampleView()
}
