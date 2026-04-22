import UIKit
import Foundation
import CoreLocation

class LoginViewController: UIViewController
{
	private var splatView:AnimatedSplatView!
	private var loginView:UIView!
	private var createAccountView:UIView!	// view containing stuff for creating an account
	
	private var loginUsernameField:UITextField!
	private var loginPasswordField:UITextField!
	private var createUsernameField:UITextField!
	private var createPasswordField:UITextField!
	private var createPassword2Field:UITextField!		// used to verify correct typing of password
	
	// =================================================================================
	//									UI Actions
	// =================================================================================
	
	@objc func createAccountChoice(_:AnyObject)
	{
		// present createAccountView and hide loginView
		self.view.addSubview(createAccountView)
		
		let animator = UIViewPropertyAnimator(duration:0.2, curve:.easeInOut, animations: {() -> Void in
			self.createAccountView.alpha = 1
			self.loginView.alpha = 0
		})
		
		animator.addCompletion({(UIViewAnimatingPosition) -> Void in
			self.loginView.removeFromSuperview()
		})
		
		animator.startAnimation()
	}
	
	// =================================================================================
	
	@objc func createAccount(_:AnyObject)
	{
		if let username = createUsernameField.text,
			let pass1 = createPasswordField.text,
			let pass2 = createPassword2Field.text
		{
			if (pass1 != pass2)
			{
				let alert = UIAlertController(title:"Uh-oh",
											  message:"Passwords do not match",
											  preferredStyle:.alert)
				let okay = UIAlertAction(title:"Okay",
										 style:.default,
										 handler:nil)
				alert.addAction(okay)
				self.navigationController?.present(alert, animated:true, completion:nil)

				return
			}
			
			// local verification is done -> create the account
			ServerAPI.createAccount(username:username, password:pass1, onComplete: {(error:ServerError?) -> Void in
				if let e = error
				{
					// throw up alert letting the user know we failed
					print("ERROR: \(e)")
					DispatchQueue.main.async {
						let alert = UIAlertController(title:"Uh-oh",
													  message:"Username already exists",
													  preferredStyle:.alert)
						let okay = UIAlertAction(title:"Okay",
												 style:.default,
												 handler:nil)
						alert.addAction(okay)
						self.navigationController?.present(alert, animated:true, completion:nil)
					}
				}
				else
				{
					// successfully created the account and logged in
					DispatchQueue.main.async {
						self.performSegue(withIdentifier:"LoginToMenu", sender:self)		// with animations
					}
				}
			})
		}
	}
	
	// =================================================================================
	
	@objc func login(_:AnyObject)
	{
        let username = loginUsernameField.text!
        let password = loginPasswordField.text!
		
		let onComplete = { (error: ServerError?) -> Void in
			if let error = error {
				print("ERROR: \(error)")
				DispatchQueue.main.async {
					let alert = UIAlertController(title:"Uh-oh",
												  message:"Invalid username or password",
												  preferredStyle:.alert)
					let okay = UIAlertAction(title:"Okay",
											 style:.cancel,
											 handler: nil)
					
					alert.addAction(okay)
					self.navigationController?.present(alert, animated:true, completion:nil)
				}
			} else {
				DispatchQueue.main.async {
					self.performSegue(withIdentifier:"LoginToMenu", sender:self)
				}
				
			}
		}
		
		let _ = ServerAPI.login(withUsername: username, andPassword: password, onComplete: onComplete)
	}
	
	// =================================================================================
	
	@objc func hideKeyboard(sender:AnyObject)
	{
		if let v = sender as? UITextField
		{
			v.resignFirstResponder()
		}
	}
	
	// =================================================================================
	//									UI Setup
	// =================================================================================
	
	private func createLoginView()
	{
		let width = self.view.frame.size.width
		let height = self.view.frame.size.height
		
		let PADDING:CGFloat = 10
		let BUTTON_HEIGHT:CGFloat = 50
		let BUTTON_WIDTH:CGFloat = 2 * width / 3
		let TEXTFIELD_BG_WIDTH:CGFloat = BUTTON_WIDTH + (2 * PADDING)
		let TEXTFIELD_BG_HEIGHT:CGFloat = 45
		
		loginView = UIView()
		
		let usernameBackground = UIView()
		usernameBackground.alpha = 0.06
		usernameBackground.frame = CGRect(x:0, y:0, width:TEXTFIELD_BG_WIDTH, height:TEXTFIELD_BG_HEIGHT)
		usernameBackground.backgroundColor = .black
		usernameBackground.layer.cornerRadius = 5
		usernameBackground.layer.masksToBounds = true
		loginView.addSubview(usernameBackground)
		
		loginUsernameField = UITextField(frame:CGRect(x:0, y:0, width:BUTTON_WIDTH, height:BUTTON_HEIGHT))
		loginUsernameField.center = usernameBackground.center
		loginUsernameField.placeholder = "Username"
		loginUsernameField.addTarget(self, action:#selector(hideKeyboard(sender:)), for:.editingDidEndOnExit)
		loginView.addSubview(loginUsernameField)
		
		let passwordBackground = UIView()
		passwordBackground.alpha = 0.06
		passwordBackground.frame = CGRect(x:0, y:usernameBackground.frame.maxY + PADDING, width:TEXTFIELD_BG_WIDTH, height:TEXTFIELD_BG_HEIGHT)
		passwordBackground.backgroundColor = .black
		passwordBackground.layer.cornerRadius = 5
		passwordBackground.layer.masksToBounds = true
		loginView.addSubview(passwordBackground)
		
		loginPasswordField = UITextField(frame:CGRect(x:0, y:0, width:BUTTON_WIDTH, height:BUTTON_HEIGHT))
		loginPasswordField.center = passwordBackground.center
		loginPasswordField.placeholder = "Password"
		loginPasswordField.isSecureTextEntry = true
		loginPasswordField.addTarget(self, action:#selector(hideKeyboard(sender:)), for:.editingDidEndOnExit)
		loginView.addSubview(loginPasswordField)
		
		let loginButton = MyUtilities.buttonWithSize(size:CGSize(width:BUTTON_WIDTH, height:BUTTON_HEIGHT))
		loginButton.frame.origin.y = loginPasswordField.frame.maxY + (3 * PADDING)
		loginButton.center.x = loginUsernameField.center.x
		loginButton.setTitle("Log in", for:.normal)
		loginButton.addTarget(self, action:#selector(login(_:)), for:.touchUpInside)
		loginView.addSubview(loginButton)
		
		let createAccountButton = MyUtilities.buttonWithSize(size:CGSize(width:BUTTON_WIDTH, height:BUTTON_HEIGHT))
		createAccountButton.frame.origin.y = loginButton.frame.maxY + PADDING
		createAccountButton.center.x = loginButton.center.x
		createAccountButton.setTitle("Create Account", for:.normal)
		createAccountButton.addTarget(self, action:#selector(createAccountChoice(_:)), for:.touchUpInside)
		loginView.addSubview(createAccountButton)
		
		MyUtilities.shrinkWrap(view:loginView)
		loginView.center = CGPoint(x:width / 2, y:height / 2)
	}
	
	// =================================================================================
	
	private func createCreateAccountView()
	{
		let width = self.view.frame.size.width
		let height = self.view.frame.size.height
		
		let PADDING:CGFloat = 10
		let BUTTON_HEIGHT:CGFloat = 50
		let BUTTON_WIDTH:CGFloat = 2 * width / 3
		let TEXTFIELD_BG_WIDTH:CGFloat = BUTTON_WIDTH + (2 * PADDING)
		let TEXTFIELD_BG_HEIGHT:CGFloat = 45
		
		createAccountView = UIView()
		
		let usernameBackground = UIView()
		usernameBackground.alpha = 0.08
		usernameBackground.frame = CGRect(x:0, y:0, width:TEXTFIELD_BG_WIDTH, height:TEXTFIELD_BG_HEIGHT)
		usernameBackground.backgroundColor = .black
		usernameBackground.layer.cornerRadius = 5
		usernameBackground.layer.masksToBounds = true
		createAccountView.addSubview(usernameBackground)
		
		createUsernameField = UITextField(frame:CGRect(x:0, y:0, width:BUTTON_WIDTH, height:BUTTON_HEIGHT))
		createUsernameField.center = usernameBackground.center
		createUsernameField.placeholder = "Username"
		createUsernameField.addTarget(self, action:#selector(hideKeyboard(sender:)), for:.editingDidEndOnExit)
		createAccountView.addSubview(createUsernameField)
		
		let passwordBackground = UIView()
		passwordBackground.alpha = 0.08
		passwordBackground.frame = CGRect(x:0, y:usernameBackground.frame.maxY + PADDING, width:TEXTFIELD_BG_WIDTH, height:TEXTFIELD_BG_HEIGHT)
		passwordBackground.backgroundColor = .black
		passwordBackground.layer.cornerRadius = 5
		passwordBackground.layer.masksToBounds = true
		createAccountView.addSubview(passwordBackground)
		
		createPasswordField = UITextField(frame:CGRect(x:0, y:0, width:BUTTON_WIDTH, height:BUTTON_HEIGHT))
		createPasswordField.center = passwordBackground.center
		createPasswordField.placeholder = "Password"
		createPasswordField.isSecureTextEntry = true
		createPasswordField.addTarget(self, action:#selector(hideKeyboard(sender:)), for:.editingDidEndOnExit)
		createAccountView.addSubview(createPasswordField)
		
		let password2Background = UIView()
		password2Background.alpha = 0.08
		password2Background.frame = CGRect(x:0, y:passwordBackground.frame.maxY + PADDING, width:TEXTFIELD_BG_WIDTH, height:TEXTFIELD_BG_HEIGHT)
		password2Background.backgroundColor = .black
		password2Background.layer.cornerRadius = 5
		password2Background.layer.masksToBounds = true
		createAccountView.addSubview(password2Background)
		
		createPassword2Field = UITextField(frame:CGRect(x:0, y:0, width:BUTTON_WIDTH, height:BUTTON_HEIGHT))
		createPassword2Field.center = password2Background.center
		createPassword2Field.placeholder = "Verify Password"
		createPassword2Field.isSecureTextEntry = true
		createPassword2Field.addTarget(self, action:#selector(hideKeyboard(sender:)), for:.editingDidEndOnExit)
		createAccountView.addSubview(createPassword2Field)
		
		let createButton = MyUtilities.buttonWithSize(size:CGSize(width:BUTTON_WIDTH, height:BUTTON_HEIGHT))
		createButton.frame.origin.y = createPassword2Field.frame.maxY + (2 * PADDING)
		createButton.center.x = createUsernameField.center.x
		createButton.setTitle("Create Account", for:.normal)
		createButton.addTarget(self, action:#selector(createAccount(_:)), for:.touchUpInside)
		createAccountView.addSubview(createButton)
		
		MyUtilities.shrinkWrap(view:createAccountView)
		createAccountView.center = CGPoint(x:width / 2, y:height / 2)
	}
	
	// =================================================================================
	//								UIViewController
	// =================================================================================
	
	override func viewDidDisappear(_ animated: Bool)
	{
		splatView.reset()
		
		if (loginView.superview == nil)
		{
			loginView.alpha = 1
			self.view.addSubview(loginView)
		}
		
		if (createAccountView.superview != nil)
		{
			createAccountView.alpha = 0
			createAccountView.removeFromSuperview()
		}
	}
	
	// =================================================================================
	
	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)
		splatView.start()
		
		if (loginView.superview == nil)
		{
			loginView.alpha = 1
			self.view.addSubview(loginView)
		}
		
		if (createAccountView.superview != nil)
		{
			createAccountView.alpha = 0
			createAccountView.removeFromSuperview()
		}
	}
	
	// =================================================================================
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		if (AppData.currentUser != nil)
		{
			// TODO: create custom, no-animation segue and use it here
			self.performSegue(withIdentifier:"LoginToMenuNoAnimation", sender:self)
		}
		
		// create the splat view
		createLoginView()
		createCreateAccountView()
		
		splatView = AnimatedSplatView(frame:self.view.bounds)
		splatView.exclusionZones.append(loginView.frame.insetBy(dx:-30, dy:-30))
		splatView.exclusionZones.append(createAccountView.frame.insetBy(dx:-30, dy:-30))
		self.view.insertSubview(splatView, at:0)
	}
	
	// =================================================================================
	
	override var prefersStatusBarHidden: Bool
	{
		return true
	}
	
	// =================================================================================
}
