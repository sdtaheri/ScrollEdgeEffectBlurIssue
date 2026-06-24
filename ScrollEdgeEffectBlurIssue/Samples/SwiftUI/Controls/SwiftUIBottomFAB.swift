//
//  SwiftUIBottomFAB.swift
//  ScrollEdgeEffectBlurIssue
//
//  Created by Saeed Taheri on 2026/6/11.
//

import SwiftUI

struct SwiftUIBottomFAB: View {
    var body: some View {
        HStack {
            Spacer()
            Button {
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(Color.blue, in: Circle())
                    .shadow(color: .black.opacity(0.24), radius: 12, x: 0, y: 6)
            }
            .buttonStyle(.plain)
            .padding(.trailing, 16)
            .padding(.bottom, 16)
            .accessibilityLabel("Add")
        }
    }
}
