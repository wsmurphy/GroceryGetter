//
//  AppDelegate.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 12/29/14.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var mealArray :Array<Meal> = []
    var menuArray :Array<Menu> = []

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //TODO: Replace with actual data
        var meal = Meal()
        meal.mealName = "Meal 1"
        meal.ingredientArray = ["Item 1", "Item 2"]
        
        var meal2 = Meal()
        meal2.mealName = "Meal 2"
        meal2.ingredientArray = ["Item 3", "Item 4"]
        
        var meal3 = Meal()
        meal3.mealName = "Meal 3"
        meal3.ingredientArray = ["Item 3", "Item 4", "Item 4", "Item 4", "Item 4", "Item 4"]
        
        var meal4 = Meal()
        meal4.mealName = "Meal 4"
        meal4.ingredientArray = ["Item 3", "Item 4", "Item 4", "Item 4"]
        
        mealArray.append(meal)
        mealArray.append(meal2)
        mealArray.append(meal3)
        mealArray.append(meal4)
        
        var menu = Menu()
        menu.menuName = "Menu 1"
        menu.mealArray = [meal, meal2, meal2]
        
        var menu1 = Menu()
        menu1.menuName = "Menu 2"
        menu1.mealArray = [meal, meal2, meal2]
        
        menuArray.append(menu)
        menuArray.append(menu1)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

