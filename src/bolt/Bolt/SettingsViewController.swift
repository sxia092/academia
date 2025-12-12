//
//  SettingsViewController.swift
//  Bolt
//
//  Created by Illya Starikov on 7/24/16.
//  Copyright © 2016 Illya Starikov. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    var defaults = UserDefaults()
    
 func repeatsValueChanged(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: "Repeats")
    }
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination
    
        if let navigationController = destinationVC as? UINavigationController {
            destinationVC = navigationController.visibleViewController ?? destinationVC
        }
        
        if let boltVC = destinationVC as? BoltViewController {
            boltVC.defaults = defaults
        }
        
    }


}
