//
//  Created by Marek Niedbach on 03.09.2017.
//  Copyright © 2017 Marek Niedbach. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // swiftlint:disable:next line_length
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: DiceBoardViewController())
        window?.makeKeyAndVisible()

        return true
    }
}
