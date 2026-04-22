import UIKit

class OptionsViewController: UIViewController
{
	private let defaults = UserDefaults.standard
	
	private var logoutButton:UIButton!
	
	// =================================================================================
	//							Change Settings Functions 
	// =================================================================================
	
	@objc func toggleSounds(sender:AnyObject)
	{
		let value = (sender as! UISwitch).isOn
		defaults.set(value, forKey:SETTING_SOUNDS_ON)
		defaults.synchronize()
	}
	
	// =================================================================================
	
	@objc func toggleMinimap(sender:AnyObject)
	{
		let value = (sender as! UISwitch).isOn
		defaults.set(value, forKey:SETTING_MINIMAP_ON)
		defaults.synchronize()
	}
	
	// =================================================================================
	
	@objc func changeMinimapTransparency(sender:AnyObject)
	{
		let value = Int((sender as! UISlider).value)
		defaults.set(value, forKey:SETTING_MINIMAP_ALPHA)
		defaults.synchronize()
	}
	
	// =================================================================================
	
	@objc func changePaintTransparency(sender:AnyObject)
	{
		let value = Int((sender as! UISlider).value)
		defaults.set(value, forKey:SETTING_PAINT_ALPHA)
		defaults.synchronize()
	}
	
	// =================================================================================
	//								Other UI Functions
	// =================================================================================
	
	@objc func logoutPressed(_:AnyObject)
	{
		
		// confirm the user's choice to logout
		let alert = UIAlertController(title:"Log out", message:"Are you sure you want to log out?", preferredStyle:.alert)
		let cancel = UIAlertAction(title:"Cancel", style:.default, handler:nil)
		let logout = UIAlertAction(title:"Yes, I'm sure", style:.destructive, handler:{ (_:UIAlertAction) -> Void in
			if let vcs = self.navigationController?.viewControllers
			{
				ServerAPI.logoutUser { (error: ServerError?) in
					if let error = error {
						print("ERROR: \(error)")
						DispatchQueue.main.async {
							let alert = UIAlertController(title:"Uh-oh",
														  message:"Could not logout",
														  preferredStyle:.alert)
							let okay = UIAlertAction(title:"Okay",
													 style:.cancel,
													 handler: nil)
							
							alert.addAction(okay)
							self.navigationController?.present(alert, animated:true, completion:nil)
						}
					} else {
						AppData.currentUser = nil
						
						DispatchQueue.main.async {
							let loginVC = vcs[vcs.count - 3]		// 2 back from this vc
							self.navigationController?.popToViewController(loginVC, animated:true)
							// TODO: error handle for when not successful
						}
						
					}
				}
				


			}
		})
		
		alert.addAction(logout)
		alert.addAction(cancel)
		self.present(alert, animated:true, completion:nil)
	}
	
	// =================================================================================
	
	@objc func backPressed(_:UIView)
	{
		self.navigationController?.popViewController(animated:true)
	}
	
	// =================================================================================
	//								UIViewController
	// =================================================================================
	
	private func setupUI()
	{
		let width = self.view.frame.size.width
		let PADDING:CGFloat = 10				// space between views in self.view
		let BORDER:CGFloat = 10					// space between the edge of self.view's frame and the section frames
		let OUTER_PADDING:CGFloat = 10			// space between the edge of a section's frame and its subviews
		let SECTION_WIDTH:CGFloat = width - (2 * PADDING)
		let BUTTON_WIDTH:CGFloat = SECTION_WIDTH
		let BUTTON_HEIGHT:CGFloat = 50
		
		// create the title label
		let title = UILabel()
		title.text = "Options"
		title.font = UIFont.systemFont(ofSize:40)
		title.sizeToFit()
		title.center = CGPoint(x:width / 2, y:(2 * PADDING) + (title.frame.size.height / 2))
		self.view.addSubview(title)
		
		// create the back button
		let backImage = UIImageView(image:UIImage(named:"backArrow.png"))
		backImage.frame = CGRect(x:14, y:14, width:40, height:40)
		self.view.addSubview(backImage)
		
		let backButton = UIButton(type:.custom)
		backButton.frame = CGRect(x:0, y:0, width:67, height:67)
		backButton.addTarget(self, action:#selector(backPressed(_:)), for:.touchUpInside)
		self.view.addSubview(backButton)
		
		// create the sections
		// TODO: create a color blind mode - how?
		var y:CGFloat = title.frame.maxY + (2 * PADDING)
		let settingLabels:[String] = ["Sounds", "Minimap", "Minimap Transparency", "Paint Transparency"]
		let settingInputs:[UIView] = [UISwitch(), UISwitch(), UISlider(), UISlider()]
		let settingActions:[Selector] = [#selector(toggleSounds(sender:)),
										 #selector(toggleMinimap(sender:)),
										 #selector(changeMinimapTransparency(sender:)),
										 #selector(changePaintTransparency(sender:))]
		
		for i in 0..<settingLabels.count
		{
			let sectionFrame = CGRect(x:BORDER, y:y, width:SECTION_WIDTH, height:0)
			let section = UIView(frame:sectionFrame)
			
			// background
			let background = UIView()
			background.alpha = 0.25
			background.backgroundColor = .black
			background.layer.cornerRadius = 5
			background.layer.masksToBounds = true
			section.addSubview(background)
			
			// name of the option/setting
			let label = UILabel()
			label.text = settingLabels[i]
			label.sizeToFit()
			label.center = CGPoint(x:OUTER_PADDING + (label.frame.size.width / 2), y:OUTER_PADDING + (label.frame.size.height / 2))
			section.addSubview(label)
			
			// input control
			(settingInputs[i] as! UIControl).addTarget(self, action:settingActions[i], for:.valueChanged)
			
			if let input = settingInputs[i] as? UISwitch
			{
				// put the switch to the right of the label
				section.frame.size.height = OUTER_PADDING + max(label.frame.size.height, input.frame.size.height) + OUTER_PADDING
				
				input.center = CGPoint(x:section.frame.size.width - (PADDING + input.frame.size.width / 2),
									   y:section.frame.size.height / 2)
				
				// readjust the label position if the switch is tall enough that it is no longer vertically centered
				if (input.frame.size.height > label.frame.size.height)
				{
					label.center.y = section.frame.size.height / 2
				}
			}
			else if let slider = settingInputs[i] as? UISlider
			{
				// put the slider below the label
				let sliderWidth = section.frame.size.width - (2 * OUTER_PADDING)
				slider.frame = CGRect(x:OUTER_PADDING, y:label.frame.maxY + PADDING, width:sliderWidth, height:slider.frame.size.height)
				section.frame.size.height = OUTER_PADDING + label.frame.size.height + PADDING + slider.frame.size.height + OUTER_PADDING
			}
			
			section.addSubview(settingInputs[i])
			self.view.addSubview(section)
			
			// finalize the background now that we have the final dimensions of the section
			background.frame = section.bounds
			
			y += section.frame.size.height + PADDING
		}
		
		// logout button
		logoutButton = MyUtilities.buttonWithSize(size:CGSize(width:BUTTON_WIDTH, height:BUTTON_HEIGHT))
		logoutButton.frame.origin.y = y
		logoutButton.center.x = width / 2
		logoutButton.setTitle("Log out", for:.normal)
		logoutButton.addTarget(self, action:#selector(logoutPressed(_:)), for:.touchUpInside)
		logoutButton.isEnabled = (AppData.currentUser != nil)
		logoutButton.adjustsImageWhenHighlighted = true
		self.view.addSubview(logoutButton)
		
		y += logoutButton.frame.size.height + PADDING
		
		// set initial values
		(settingInputs[0] as! UISwitch).isOn = defaults.bool(forKey:SETTING_SOUNDS_ON)
		(settingInputs[1] as! UISwitch).isOn = defaults.bool(forKey:SETTING_MINIMAP_ON)
		(settingInputs[2] as! UISlider).minimumValue = 0
		(settingInputs[2] as! UISlider).maximumValue = 255
		(settingInputs[2] as! UISlider).value = Float(defaults.integer(forKey:SETTING_MINIMAP_ALPHA))
		(settingInputs[3] as! UISlider).minimumValue = 0
		(settingInputs[3] as! UISlider).maximumValue = 255
		(settingInputs[3] as! UISlider).value = Float(defaults.integer(forKey:SETTING_PAINT_ALPHA))
	}
	
	// =================================================================================
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		setupUI()
	}
	
	// =================================================================================
	
	override var prefersStatusBarHidden: Bool
	{
		return true
	}
	
	// =================================================================================
}
