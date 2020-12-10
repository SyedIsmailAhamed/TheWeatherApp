//
//  AppDelegate.swift
//  TheWeatherApp
//
//  Created by OSE on 12/9/20.
//

import UIKit
import RealmSwift
import CoreLocation
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        StorageManager.shared().registerRealmables()

        let userArr = StorageManager.shared().fetchData(with: User.self)
        if userArr.count > 0 {
            Commons.currentUser = userArr[0]
        } else {
            //assuming first time
            let currentUser = User.shared()
            StorageManager.shared().saveData(model: currentUser) { (status) in
                if status{
                    Commons.currentUser = currentUser
                }
            }
        }
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.syed.TheWeatherApp",
                                        using: nil) { (task) in
            self.handleAppRefreshTask(task: task as! BGAppRefreshTask)

        }
       
        return true
    }


    func handleAppRefreshTask(task: BGAppRefreshTask) {
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        BackgroundDataManager.shared().fetchWeatherData { (status) in
            print("latest weather data fetched in background")
            NotificationCenter.default.post(name: .latestWeatherDataFetched,
                                            object: self,
                                            userInfo: nil)
            task.setTaskCompleted(success: true)
        }
        scheduleBackgroundWeatherFetch()
    }

    func scheduleBackgroundWeatherFetch() {
        let weatherTask = BGAppRefreshTaskRequest(identifier: "com.syed.TheWeatherApp")
        weatherTask.earliestBeginDate = Date(timeIntervalSinceNow: 10)
        do {
            try BGTaskScheduler.shared.submit(weatherTask)
        } catch {
            print("Unable to submit task: \(error.localizedDescription)")
        }
    }
   
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


    // MARK :- Realm Migration
    func performRealmMigrationifAny() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,

            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically

                    // if just the name of your model's property changed you can do this
                    /*
                     migration.renameProperty(onType: NotSureItem.className(), from: "text", to: "title")
                     */

                    // if you want to fill a new property with some values you have to enumerate
                    // the existing objects and set the new value
                    /*
                     migration.enumerateObjects(ofType: NotSureItem.className()) { oldObject, newObject in
                     let text = oldObject!["text"] as! String
                     newObject!["textDescription"] = "The title is \(text)"
                     }*/

                    // if you added a new property or removed a property you don't
                    // have to do anything because Realm automatically detects that
                }
            })

        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }

}

