//
//  UIKitEdgeEffectController.swift
//  ScrollEdgeEffectBlurIssue
//
//  Created by Saeed Taheri on 2026/6/11.
//

import UIKit

final class UIKitEdgeEffectController {
    private weak var configurableViewController: (UIViewController & UIKitEdgeEffectConfigurable)?
    private weak var scrollView: UIScrollView?
    private var topContainerInteraction: UIScrollEdgeElementContainerInteraction?
    private var bottomContainerInteraction: UIScrollEdgeElementContainerInteraction?
    private var topMenuButton: UIButton?
    private var currentChoice: EdgeEffectChoice = .automatic

    func install(on viewController: UIViewController & UIKitEdgeEffectConfigurable, scrollView: UIScrollView) {
        self.configurableViewController = viewController
        self.scrollView = scrollView

        installTopMenu(on: viewController, scrollView: scrollView)
        installBottomFAB(on: viewController, scrollView: scrollView)
        apply(.automatic)
    }

    func apply(_ choice: EdgeEffectChoice) {
        currentChoice = choice
        scrollView?.topEdgeEffect.style = choice.uiKitStyle
        scrollView?.bottomEdgeEffect.style = choice.uiKitStyle
        updateMenuButtonTitle()
        topMenuButton?.menu = makeEdgeMenu()
    }

    private func installTopMenu(on viewController: UIViewController, scrollView: UIScrollView) {
        let button = makeMenuButton()
        button.menu = makeEdgeMenu()
        button.showsMenuAsPrimaryAction = true
        viewController.view.addSubview(button)
        topMenuButton = button

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: viewController.view.layoutMarginsGuide.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])

        let interaction = UIScrollEdgeElementContainerInteraction()
        interaction.scrollView = scrollView
        interaction.edge = .top
        button.addInteraction(interaction)
        topContainerInteraction = interaction
    }

    private func installBottomFAB(on viewController: UIViewController, scrollView: UIScrollView) {
        let button = makeCircleButton(
            systemImageName: "plus",
            pointSize: 24,
            backgroundColor: .systemBlue,
            foregroundColor: .white,
            size: 56
        )
        viewController.view.addSubview(button)

        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: viewController.view.layoutMarginsGuide.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            button.widthAnchor.constraint(equalToConstant: 56),
            button.heightAnchor.constraint(equalToConstant: 56)
        ])

        let interaction = UIScrollEdgeElementContainerInteraction()
        interaction.scrollView = scrollView
        interaction.edge = .bottom
        button.addInteraction(interaction)
        bottomContainerInteraction = interaction
    }

    private func makeMenuButton() -> UIButton {
        var configuration = UIButton.Configuration.plain()
        configuration.title = menuButtonTitle
        configuration.image = UIImage(systemName: "line.3.horizontal.decrease.circle")
        configuration.imagePadding = 8
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14)
        configuration.baseForegroundColor = .tintColor

        let button = UIButton(configuration: configuration)
        button.backgroundColor = .systemBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 22
        button.layer.cornerCurve = .continuous
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.24
        button.layer.shadowRadius = 12
        button.layer.shadowOffset = CGSize(width: 0, height: 6)
        button.accessibilityLabel = menuButtonTitle
        return button
    }

    private func updateMenuButtonTitle() {
        topMenuButton?.configuration?.title = menuButtonTitle
        topMenuButton?.accessibilityLabel = menuButtonTitle
    }

    private var menuButtonTitle: String {
        "Effect Style: \(currentChoice.title)"
    }

    private func makeCircleButton(
        systemImageName: String,
        pointSize: CGFloat,
        backgroundColor: UIColor,
        foregroundColor: UIColor,
        size: CGFloat
    ) -> UIButton {
        let button = UIButton(type: .system)
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: .semibold)
        button.setImage(UIImage(systemName: systemImageName, withConfiguration: imageConfiguration), for: .normal)
        button.tintColor = foregroundColor
        button.backgroundColor = backgroundColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = size / 2
        button.layer.cornerCurve = .continuous
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.24
        button.layer.shadowRadius = 12
        button.layer.shadowOffset = CGSize(width: 0, height: 6)
        button.accessibilityLabel = systemImageName == "plus" ? "Add" : "Effect Style"
        return button
    }

    private func makeEdgeMenu() -> UIMenu {
        UIMenu(
            title: "Effect Style",
            children: EdgeEffectChoice.allCases.map { choice in
                UIAction(
                    title: choice.title,
                    image: UIImage(systemName: choice.systemImage),
                    state: choice == currentChoice ? .on : .off
                ) { [weak self] _ in
                    self?.configurableViewController?.apply(edgeEffectChoice: choice)
                }
            }
        )
    }
}
