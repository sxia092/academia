import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
	var window: UIWindow?

	// =================================================================================

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
	{
		AppData.initialize()
		triggerSystemLocationServicesAlerts()

		if AppData.DEMO_MODE
		{
			configureDemoMode()
		}

		return true
	}

	// =================================================================================
	// Skip login and drop the user straight into the main menu, with a fake signed-in
	// user attached so downstream code that touches AppData.currentUser still works.
	private func configureDemoMode()
	{
		let demoUser = User()
		demoUser.ID = 1
		demoUser.session = "demo-session"
		demoUser.name = "demo"
		AppData.currentUser = demoUser

		let storyboard = UIStoryboard(name:"Main", bundle:nil)
		guard let menu = storyboard.instantiateViewController(withIdentifier:"MenuViewController") as? MenuViewController else
		{
			print("ERROR: Could not instantiate MenuViewController from Main.storyboard — falling back to storyboard default")
			return
		}

		let nav = UINavigationController(rootViewController:menu)
		nav.isNavigationBarHidden = true

		if window == nil
		{
			window = UIWindow(frame:UIScreen.main.bounds)
		}
		window?.rootViewController = nav
		window?.makeKeyAndVisible()
	}
	
	// =================================================================================
	
	func applicationWillResignActive(_ application: UIApplication)
	{
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
		AppData.save()
	}
	
	// =================================================================================
	
	func applicationDidEnterBackground(_ application: UIApplication)
	{
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
		AppData.save()
	}
	
	// =================================================================================
	
	func applicationWillEnterForeground(_ application: UIApplication)
	{
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
		AppData.initializeUserDefaults()
		triggerSystemLocationServicesAlerts()
	}
	
	// =================================================================================
	
	func applicationDidBecomeActive(_ application: UIApplication)
	{
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
		AppData.initializeUserDefaults()
		triggerSystemLocationServicesAlerts()
	}
	
	// =================================================================================
	
	func applicationWillTerminate(_ application: UIApplication)
	{
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
		AppData.save()
	}

	// =================================================================================
	//									GPSManager Stuff
	// =================================================================================
	
	func triggerSystemLocationServicesAlerts()
	{
		if AppData.DEMO_MODE { return }
		// Turn Location Services on and off to trigger the system alerts if we don't have permissions
		// don't display the returned alert so that if a system alert appears, the user doesn't get two alerts
		if (GPSManager.defaultManager().turnOn() == nil)
		{
			GPSManager.defaultManager().turnOff()
		}
	}
	
	// =================================================================================
}

