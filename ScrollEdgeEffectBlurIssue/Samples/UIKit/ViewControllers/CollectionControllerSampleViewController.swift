//
//  CollectionControllerSampleViewController.swift
//  ScrollEdgeEffectBlurIssue
//
//  Created by Saeed Taheri on 2026/6/11.
//

import UIKit

final class CollectionControllerSampleViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIKitEdgeEffectConfigurable {
    private let items = SampleData.rows(prefix: "Controller item")
    private let edgeEffectController = UIKitEdgeEffectController()

    init() {
        super.init(collectionViewLayout: CollectionLayoutFactory.makeFlowLayout())
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        collectionView.collectionViewLayout = CollectionLayoutFactory.makeFlowLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "VC"
        collectionView.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: "GridCell")
        setContentScrollView(collectionView)
        edgeEffectController.install(on: self, scrollView: collectionView)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCollectionViewCell
        cell.configure(
            title: items[indexPath.item],
            subtitle: "UICollectionViewController",
            systemImageName: "rectangle.grid.1x2"
        )
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let columns: CGFloat = traitCollection.horizontalSizeClass == .regular ? 4 : 2
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let horizontalInsets = (flowLayout?.sectionInset.left ?? 0) + (flowLayout?.sectionInset.right ?? 0)
        let spacing = (columns - 1) * (flowLayout?.minimumInteritemSpacing ?? 0)
        let width = floor((collectionView.bounds.width - horizontalInsets - spacing) / columns)
        return CGSize(width: width, height: 132)
    }

    func apply(edgeEffectChoice: EdgeEffectChoice) {
        edgeEffectController.apply(edgeEffectChoice)
    }
}
