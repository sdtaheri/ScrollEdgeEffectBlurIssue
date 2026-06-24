//
//  SwiftUIListSampleView.swift
//  ScrollEdgeEffectBlurIssue
//
//  Created by Saeed Taheri on 2026/6/11.
//

import SwiftUI

struct SwiftUIListSampleView: View {
    @State private var edgeEffectChoice: EdgeEffectChoice = .automatic
    private let items = SampleData.rows(prefix: "SwiftUI list row")

    var body: some View {
        NavigationStack {
            List(items, id: \.self) { item in
                Label(item, systemImage: "list.bullet")
            }
            .navigationTitle("List")
            .safeAreaBar(edge: .bottom) {
                SwiftUIBottomFAB()
            }
            // Moving the top bar here reproduces the janky scroll behavior this sample is meant to isolate.
            // .safeAreaBar(edge: .top) {
            //     SwiftUITopEdgeEffectMenuBar(selection: $edgeEffectChoice)
            // }
        }
        .safeAreaBar(edge: .top) {
            SwiftUITopEdgeEffectMenuBar(selection: $edgeEffectChoice)
        }
        .scrollEdgeEffectStyle(edgeEffectChoice.swiftUIStyle, for: .all)
    }
}

#Preview {
    SwiftUIListSampleView()
}
