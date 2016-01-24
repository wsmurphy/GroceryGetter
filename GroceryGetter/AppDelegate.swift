//
//  AppDelegate.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 12/29/14.
//
//

import UIKit
import CoreData
import Fabric
import Crashlytics


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var mealArray = [Meal]()
    var menuArray = [Menu]()
    var list = [List]()
    
    var dataManager = DataManager.sharedInstance()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Fabric.with([Crashlytics.self])
        
        mealArray = dataManager.retreiveMealArray()
        menuArray = dataManager.retreiveMenuArray()
        list = dataManager.retreiveList()
        
        return true
    }
}

