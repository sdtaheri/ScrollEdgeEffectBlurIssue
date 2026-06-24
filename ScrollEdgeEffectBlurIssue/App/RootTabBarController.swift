//
//  RootTabBarController.swift
//  ScrollEdgeEffectBlurIssue
//
//  Created by Saeed Taheri on 2026/6/11.
//

import SwiftUI
import UIKit

final class RootTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        mode = .tabSidebar
        sidebar.isHidden = false
        customizationIdentifier = "ScrollEdgeEffectBlurIssue.RootTabs"

        tabs = [
            UITab(title: "Table", image: UIImage(systemName: "list.bullet"), identifier: "table") { _ in
                self.makeNavigationController(rootViewController: TableSampleViewController(), title: "Table")
            },
            UITab(title: "Grid", image: UIImage(systemName: "square.grid.2x2"), identifier: "grid") { _ in
                self.makeNavigationController(rootViewController: CollectionSampleViewController(), title: "Grid")
            },
            UITab(title: "Collection VC", image: UIImage(systemName: "rectangle.grid.1x2"), identifier: "collection-controller") { _ in
                CollectionControllerSampleViewController()
            },
            UITab(title: "List", image: UIImage(systemName: "list.bullet.rectangle"), identifier: "swiftui-list") { _ in
                UIHostingController(rootView: SwiftUIListSampleView())
            },
            UITab(title: "SwiftUI Stack", image: UIImage(systemName: "rectangle.stack"), identifier: "swiftui-stack") { _ in
                UIHostingController(rootView: SwiftUIScrollSampleView())
            }
        ]
    }

    private func makeNavigationController(rootViewController: UIViewController, title: String) -> UINavigationController {
        rootViewController.title = title
        return UINavigationController(rootViewController: rootViewController)
    }
}
