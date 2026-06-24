# ScrollEdgeEffectBlurIssue

Minimal iOS repro project for scroll edge effect and blur behavior across UIKit and SwiftUI.

This repo exists so other developers can inspect, reproduce, and help debug scroll edge effect behavior around edge-attached controls, blur, and `safeAreaBar`.

The screenshots and current repro notes are captured against an iOS 27.0 simulator, where the issues are easier to see.

The sample compares these cases:

- `UITableView` in a `UINavigationController`
- `UICollectionView` in a custom `UIViewController`
- `UICollectionViewController`
- SwiftUI `List`
- SwiftUI `ScrollView` with `LazyVStack`

Each screen exposes the scroll edge effect style controls for `automatic`, `hard`, and `soft`, plus top and bottom edge-attached controls. The SwiftUI list sample includes an inline note around the `safeAreaBar(edge: .top)` placement that appears related to janky scrolling.

## Suspected Bugs

These are the behaviors this project is trying to make obvious:

- Top edge blur can obscure or wash out the first visible row behind the floating effect-style control.
- Bottom edge blur can create an oversized hazy band around the floating action button and tab bar.
- SwiftUI `List` appears sensitive to where `safeAreaBar(edge: .top)` is attached; placing it inside the `NavigationStack` can make scrolling feel janky.
- On iOS 27.0, UI settling after tab changes and menu presentation appears noticeably less stable while capturing snapshots.
- The same edge-control pattern does not look identical across UIKit `UITableView`, UIKit `UICollectionView`, `UICollectionViewController`, SwiftUI `List`, and SwiftUI `ScrollView`.

## Screenshots

Captured on iOS 27.0 using an iPhone 17 Pro simulator.

<table>
  <tr>
    <td align="center"><strong>UIKit Table</strong></td>
    <td align="center"><strong>UIKit Grid</strong></td>
    <td align="center"><strong>UICollectionViewController</strong></td>
  </tr>
  <tr>
    <td><img src="Docs/Screenshots/table.png" width="240" alt="iOS 27 UITableView sample showing top edge blur around scroll edge effect controls"></td>
    <td><img src="Docs/Screenshots/grid.png" width="240" alt="iOS 27 UICollectionView grid sample showing scroll edge effect controls"></td>
    <td><img src="Docs/Screenshots/collection-view-controller.png" width="240" alt="iOS 27 UICollectionViewController sample showing scroll edge effect controls"></td>
  </tr>
  <tr>
    <td align="center"><strong>SwiftUI List</strong></td>
    <td align="center"><strong>SwiftUI ScrollView</strong></td>
    <td align="center"><strong>Effect Style Menu</strong></td>
  </tr>
  <tr>
    <td><img src="Docs/Screenshots/swiftui-list.png" width="240" alt="iOS 27 SwiftUI List sample with safe area bar controls"></td>
    <td><img src="Docs/Screenshots/swiftui-scrollview.png" width="240" alt="iOS 27 SwiftUI ScrollView LazyVStack sample with safe area bar controls and bottom blur"></td>
    <td><img src="Docs/Screenshots/effect-style-menu.png" width="240" alt="iOS 27 effect style menu showing Automatic Hard and Soft options above bottom edge blur"></td>
  </tr>
</table>

## Repro Notes

- The top control changes between `.automatic`, `.hard`, and `.soft`.
- The floating bottom button is attached to the bottom scroll edge.
- In `SwiftUIListSampleView`, moving the top `safeAreaBar(edge: .top)` inside the `NavigationStack` reproduces the janky scroll behavior this project is meant to isolate.
- UIKit samples use `UIScrollEdgeElementContainerInteraction`; SwiftUI samples use `safeAreaBar` and `scrollEdgeEffectStyle`.
- Prefer testing on iOS 27.0 first; the blur and scroll-edge artifacts are more visible than on iOS 26.5.

## Project Layout

```text
ScrollEdgeEffectBlurIssue/
  App/                    App lifecycle and root tab/sidebar controller
  Shared/
    Models/               Cross-framework edge effect style model
    Data/                 Small sample data helpers
  Samples/
    UIKit/
      ViewControllers/    UITableView, UICollectionView, and UICollectionViewController samples
      Views/              Reusable UIKit cells/views
      Support/            UIKit scroll edge effect wiring
    SwiftUI/
      Views/              List and ScrollView repro screens
      Controls/           Top menu and bottom button used by SwiftUI samples
  Assets.xcassets/
```

## Requirements

- Xcode 26.5 or newer
- iOS 27.0 simulator/runtime recommended for debugging the visible artifacts
- iOS 26.0 or newer deployment target

## Run

Open `ScrollEdgeEffectBlurIssue.xcodeproj`, select the `ScrollEdgeEffectBlurIssue` scheme, and run on an iPhone or iPad simulator.

From the command line:

```sh
xcodebuild \
  -project ScrollEdgeEffectBlurIssue.xcodeproj \
  -scheme ScrollEdgeEffectBlurIssue \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=27.0' \
  build
```

## What To Look At

- App entry point and tabs: `ScrollEdgeEffectBlurIssue/App/RootTabBarController.swift`
- Shared edge effect model: `ScrollEdgeEffectBlurIssue/Shared/Models/EdgeEffectChoice.swift`
- UIKit scroll edge effect setup: `ScrollEdgeEffectBlurIssue/Samples/UIKit/Support/UIKitEdgeEffectController.swift`
- SwiftUI `List` behavior: `ScrollEdgeEffectBlurIssue/Samples/SwiftUI/Views/SwiftUIListSampleView.swift`
- SwiftUI `ScrollView` behavior: `ScrollEdgeEffectBlurIssue/Samples/SwiftUI/Views/SwiftUIScrollSampleView.swift`
