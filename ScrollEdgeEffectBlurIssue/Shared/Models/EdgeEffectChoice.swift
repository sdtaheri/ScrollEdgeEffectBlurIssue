//
//  EdgeEffectChoice.swift
//  ScrollEdgeEffectBlurIssue
//
//  Created by Saeed Taheri on 2026/6/11.
//

import SwiftUI
import UIKit

enum EdgeEffectChoice: Int, CaseIterable {
    case automatic
    case hard
    case soft

    var title: String {
        switch self {
        case .automatic:
            "Automatic"
        case .hard:
            "Hard"
        case .soft:
            "Soft"
        }
    }

    var systemImage: String {
        switch self {
        case .automatic:
            "wand.and.sparkles"
        case .hard:
            "rectangle.compress.vertical"
        case .soft:
            "aqi.medium"
        }
    }

    var swiftUIStyle: ScrollEdgeEffectStyle {
        switch self {
        case .automatic:
            .automatic
        case .hard:
            .hard
        case .soft:
            .soft
        }
    }

    var uiKitStyle: UIScrollEdgeEffect.Style {
        switch self {
        case .automatic:
            .automatic
        case .hard:
            .hard
        case .soft:
            .soft
        }
    }
}
