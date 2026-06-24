//
//  SampleData.swift
//  ScrollEdgeEffectBlurIssue
//
//  Created by Saeed Taheri on 2026/6/11.
//

enum SampleData {
    static func rows(prefix: String) -> [String] {
        (1...60).map { "\(prefix) \($0)" }
    }
}
