import Foundation

// constants about the app
let APP_NAME =					"War Paint"

// constants for settings
let SETTING_MINIMAP_ON =		"settingMinimapOn"			// Bool
let SETTING_SOUNDS_ON =			"settingSoundsOn"			// Bool
let SETTING_MINIMAP_ALPHA = 	"settingMinimapAlpha"		// Int
let SETTING_PAINT_ALPHA =		"settingPaintAlpha"			// Int

// credentials
let CURRENT_USER =				"userInfo"					// User

// other constants and stuff
let TRACKING_NUM_LAUNCHES =		"trackingNumLaunches"		// Int


class AppData
{
	// Demo mode: bypass login, stub the network, and pre-fill paint so the app
	// can be launched without a live server (useful for screenshots / offline demos).
	// Flip to false to use the real login + server flow.
	static let DEMO_MODE: Bool = true

	// On the simulator, don't use GPSManager for things that need locations.
	// targetEnvironment(simulator) covers both Intel and Apple Silicon simulators;
	// the older arch(i386) || arch(x86_64) check misses Apple Silicon sims.
	#if targetEnvironment(simulator)
	static let USE_DEVICE_LOCATION = false
	#else
	static let USE_DEVICE_LOCATION = !DEMO_MODE
	#endif

	static let RETRY_INTERVAL:TimeInterval = 1

	// normal information/variables
	static var leaderboards:[Leaderboard] = [Leaderboard]()
	static var achievements:[AchievementClassID:AchievementClass] = [AchievementClassID:AchievementClass]()
	static var currentUser:User? = nil
	static var loadingTimer:Timer? = nil

	// =================================================================================
	//									Initialization
	// =================================================================================

	static func initialize()
	{
		if !DEMO_MODE
		{
			loadAchievementMetadata()
		}
		initializeUserDefaults()
	}
	
	// =================================================================================
	//									Achievements
	// =================================================================================
	
	private static func loadAchievementMetadata()
	{
		loadingTimer = Timer.scheduledTimer(withTimeInterval:AppData.RETRY_INTERVAL, repeats:true, block:{(_:Timer) -> Void in
			ServerAPI.loadAchievementMetadata(onComplete:achievementMetadataLoaded)
		})

	}
	
	// =================================================================================
	
	private static func achievementMetadataLoaded(classes:[AchievementClass]?, error:ServerError?)
	{
		if let e = error
		{
			print("ERROR: \(e)")
			return
		}
		guard let achievementClasses = classes else { return }
		
		loadingTimer?.invalidate()
		loadingTimer = nil
		
		for c in achievementClasses
		{
			achievements[c.id] = c
		}
	}
	
	// =================================================================================
	
	static func allAchievements() -> [Achievement]
	{
		var answer = [Achievement]()
		
		for (_, value) in achievements
		{
			answer.append(contentsOf: value.achievements)
		}
		
		return answer
	}
	
	// =================================================================================
	
	static func updateAchievements(updates:[AchievementClassID:Int])
	{
		for (id, achievementClass) in achievements
		{
			guard let newCount = updates[id] else { continue }
			
			for achievement in achievementClass.achievements
			{
				achievement.currentCount = newCount
			}
		}
	}
	
	// =================================================================================
	//									User Defaults
	// =================================================================================

	static func initializeUserDefaults()
	{
		let d:UserDefaults = UserDefaults.standard
		let numLaunches:Int = d.integer(forKey:TRACKING_NUM_LAUNCHES)		// defaults to 0 if no value for this key

		// initialize values on first launch
		if (numLaunches == 0)
		{
			// settings
			d.set(true, forKey:SETTING_MINIMAP_ON)
			d.set(true, forKey:SETTING_SOUNDS_ON)
			d.set(100, forKey:SETTING_MINIMAP_ALPHA)
			d.set(100, forKey:SETTING_PAINT_ALPHA)

			// currentUser - no need to set because defaults to nil
		}
		else if !DEMO_MODE
		{
			if let data = d.object(forKey:CURRENT_USER) as? Data
			{
				if let user = NSKeyedUnarchiver.unarchiveObject(with:data) as? User
				{
					currentUser = user
				}
			}
		}

		// Demo mode: use 70% paint opacity so the map labels stay readable under
		// the splats — nicer for screenshots than the default 100%.
		if DEMO_MODE
		{
			d.set(180, forKey:SETTING_PAINT_ALPHA)
		}

		d.set(numLaunches + 1, forKey:TRACKING_NUM_LAUNCHES)
		d.synchronize()
	}

	// =================================================================================
	
	static func save()
	{
		if DEMO_MODE { return }

		let d:UserDefaults = UserDefaults.standard

		if let user = currentUser
		{
			let data = NSKeyedArchiver.archivedData(withRootObject:user)
			d.set(data, forKey:CURRENT_USER)
		}

		d.synchronize()
	}
	
	// =================================================================================
}




