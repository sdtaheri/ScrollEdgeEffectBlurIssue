//
//  TableSampleViewController.swift
//  ScrollEdgeEffectBlurIssue
//
//  Created by Saeed Taheri on 2026/6/11.
//

import UIKit

final class TableSampleViewController: UITableViewController, UIKitEdgeEffectConfigurable {
    private let items = SampleData.rows(prefix: "Table row")
    private let edgeEffectController = UIKitEdgeEffectController()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Table"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        setContentScrollView(tableView)
        edgeEffectController.install(on: self, scrollView: tableView)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = items[indexPath.row]
        configuration.secondaryText = "UITableView inside UINavigationController"
        configuration.image = UIImage(systemName: "line.3.horizontal")
        cell.contentConfiguration = configuration
        return cell
    }

    func apply(edgeEffectChoice: EdgeEffectChoice) {
        edgeEffectController.apply(edgeEffectChoice)
    }
}
