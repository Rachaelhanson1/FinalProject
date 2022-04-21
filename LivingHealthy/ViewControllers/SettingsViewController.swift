//
//  SettingsViewController.swift
//  LivingHealthy
//
//  Created by Rachael Hanson on 13/04/2022.
//

import UIKit
import Firebase


class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var updateEmailField: UITextField!
    @IBOutlet weak var accountView: UIView!

    //choosing taget goals gor goal tracker page
    @IBOutlet weak var cardioMax: UITextField!
    @IBOutlet weak var flexMax: UITextField!
    @IBOutlet weak var strengthMax: UITextField!
    @IBOutlet weak var stepsMax: UITextField!
    
    
    
    
    @IBOutlet weak var cardioL: UILabel!
    // ability level picker
    @IBOutlet weak var levelPicker: UIPickerView!
    var levelData: [String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        accountView.layer.cornerRadius = 10
        
        //creating a picker for user ability level
        levelPicker.delegate = self
        levelPicker.dataSource = self
        
        levelData = ["Beginner", "Intermediate", "Advanced"]
    }
    
    
    @IBAction func confirm(_ sender: UIButton) {
        
        let tabbar = tabBarController as! mainTabBarViewController
        
        let cardioVal = Int(cardioMax.text!)
        tabbar.cardioValue = cardioVal!
        
        let flexVal = Int(flexMax.text!)
        tabbar.flexValue = flexVal!
        
        let strengthVal = Int(strengthMax.text!)
        tabbar.strengthValue = strengthVal!
        
        let stepVal = Int(stepsMax.text!)
        tabbar.stepValue = stepVal!
        
        cardioL.text = "\(String(describing: cardioMax.text)) \(tabbar.cardioValue)"
    }
    
    //functions for the picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return levelData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return levelData[row]
    }
    

    //updating email to Firebase

    @IBAction func updateUserButton(_ sender: Any) {
        let auth = Auth.auth()
            guard let email = self.updateEmailField.text ?? auth.currentUser?.email else { return }
                // email that i have to update with current user email
            auth.currentUser?.updateEmail(to: (email), completion: { (error) in
                    if error == nil{

                    }else{
                    }
                })

    }
    
    
}
    

