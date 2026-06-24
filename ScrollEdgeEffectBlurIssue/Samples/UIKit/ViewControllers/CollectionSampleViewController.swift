//
//  CollectionSampleViewController.swift
//  ScrollEdgeEffectBlurIssue
//
//  Created by Saeed Taheri on 2026/6/11.
//

import UIKit

final class CollectionSampleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIKitEdgeEffectConfigurable {
    private let items = SampleData.rows(prefix: "Grid item")
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionLayoutFactory.makeFlowLayout())
    private let edgeEffectController = UIKitEdgeEffectController()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Grid"
        view.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: "GridCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        setContentScrollView(collectionView)
        edgeEffectController.install(on: self, scrollView: collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCollectionViewCell
        cell.configure(
            title: items[indexPath.item],
            subtitle: "UICollectionView + flow layout",
            systemImageName: "square.grid.2x2"
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
