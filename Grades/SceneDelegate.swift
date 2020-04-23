//
//  SceneDelegate.swift
//  Grades
//
//  Created by Ignacio Paradisi on 3/29/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new
        // (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupToolbar(for: windowScene)
        window = UIWindow(windowScene: windowScene)
        #if targetEnvironment(macCatalyst)
        window?.rootViewController = GradesSplitViewController()
        #else
        window?.rootViewController = MainTabBarController()
        #endif
        window?.makeKeyAndVisible()
    }
    
    func windowScene(_ windowScene: UIWindowScene, didUpdate previousCoordinateSpace: UICoordinateSpace, interfaceOrientation previousInterfaceOrientation: UIInterfaceOrientation, traitCollection previousTraitCollection: UITraitCollection) {
        NotificationCenter.default.post(name: .windowSizeDidChange, object: nil)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded
        // (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    /// Adds a toolbar to the app if it's running on macOS
    /// - Parameter scene: Current window scene
    private func setupToolbar(for scene: UIWindowScene) {
        #if targetEnvironment(macCatalyst)
        guard let titlebar = scene.titlebar else { return }
        let toolbar = NSToolbar(identifier: "GradesToolbar")
        toolbar.delegate = self
        titlebar.toolbar = toolbar
        titlebar.titleVisibility = .hidden
        #endif
    }

}

// MARK: - NSToolbarDelegate
#if targetEnvironment(macCatalyst)
extension SceneDelegate: NSToolbarDelegate {
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [.flexibleSpace, .add, .title, .back]
    }
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [.back, .flexibleSpace, .title, .flexibleSpace, .add]
    }
    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        var item: NSToolbarItem?
        switch itemIdentifier {
        case .title:
            item = NSToolbarItem(itemIdentifier: .title)
            item?.title = "Grades"
        case .add:
            let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
            item = NSToolbarItem(itemIdentifier: .add, barButtonItem: barButton)
            item?.label = "Add"
            return item
        case .back:
            let image = UIImage(systemName: "chevron.left")?.withConfiguration(UIImage.SymbolConfiguration(scale: .small))
            let barButton = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
            item = NSToolbarItem(itemIdentifier: .back, barButtonItem: barButton)
            item?.image = item?.image?.withConfiguration(UIImage.SymbolConfiguration(scale: .small))
            item?.label = "Back"
            return item
        default:
            break
        }
        return item
    }
}
#endif
