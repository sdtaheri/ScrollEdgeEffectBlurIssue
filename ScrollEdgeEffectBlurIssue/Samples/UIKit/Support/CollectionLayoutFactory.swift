//
//  CollectionLayoutFactory.swift
//  ScrollEdgeEffectBlurIssue
//
//  Created by Saeed Taheri on 2026/6/11.
//

import UIKit

enum CollectionLayoutFactory {
    static func makeFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 96, right: 16)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        return layout
    }
}
