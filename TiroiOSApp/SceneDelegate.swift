//
//  SceneDelegate.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//


import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appState = AppState()
    var tabSelection = 1


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Use a UIHostingController as window root view controller
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            //let managedObjectContext = AppDelegate.shared.persistentContainer.viewContext
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            //let store<AppState, AppAction> =
            //self.appState = AppState()
            window.rootViewController = UIHostingController(rootView: ContentView(
                tabSelection: self.tabSelection,
            store: Store(
                initialValue: self.appState,
                reducer: with(
                  appReducer,
                  //compose(
                    logging
                  //)
                )
              )
            ).environment(\.managedObjectContext, context))
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
        
        if(appState.reportingProfile != nil){
             logSingle(log: Log(action: "endSession", anonID: appState.reportingProfile!.id))
        // appState.sessionLog.append(Log(action: "endSession", anonID: appState.reportingProfile!.id))
             //networkLog(sessionLog: self.appState.sessionLog)
             //self.appState.sessionLog = [Log]()
         }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        appState.checkToday()
        if(appState.reportingProfile != nil){
            logSingle(log: Log(action: "startSession", anonID: appState.reportingProfile!.id))
            //appState.sessionLog.append(Log(action: "startSession", anonID: appState.reportingProfile!.id))
        }
        print("scene did become active")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        appState.checkToday()
        print("scene will enter foreground")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        if(appState.reportingProfile != nil){
            logSingle(log: Log(action: "endSession", anonID: appState.reportingProfile!.id))
       // appState.sessionLog.append(Log(action: "endSession", anonID: appState.reportingProfile!.id))
            //networkLog(sessionLog: self.appState.sessionLog)
            //self.appState.sessionLog = [Log]()
        }
        
        print("scene did enter background")
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

