import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let tabBar = UITabBarController()
        
        let task1 = Task1SenderViewController()
        let nav1 = UINavigationController(rootViewController: task1)
        nav1.tabBarItem = UITabBarItem(
            title: "Task 1",
            image: UIImage(systemName: "1.circle"),
            tag: 0
        )
        
        let task2 = Task2ViewController()
        let nav2 = UINavigationController(rootViewController: task2)
        nav2.tabBarItem = UITabBarItem(
            title: "Task 2",
            image: UIImage(systemName: "2.circle"),
            tag: 1
        )
        
        let task3 = Task3ViewController()
        let nav3 = UINavigationController(rootViewController: task3)
        nav3.tabBarItem = UITabBarItem(
            title: "Task 3",
            image: UIImage(systemName: "3.circle"),
            tag: 2
        )
        
        tabBar.viewControllers = [nav1, nav2, nav3]
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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
    }
}
