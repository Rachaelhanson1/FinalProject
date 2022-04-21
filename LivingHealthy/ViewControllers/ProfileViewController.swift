//
//  ProfileViewController.swift
//  LivingHealthy
//
//  Created by Rachael Hanson on 28/03/2022.
//

import Photos
import PhotosUI
import UIKit

class ProfileViewController: UIViewController, PHPickerViewControllerDelegate {
    
    //constraints for side menu
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    var menuOut = false
    @IBOutlet weak var seperators: UIView!
    @IBOutlet weak var separator2: UIView!
    @IBOutlet weak var separator3: UIView!
    
    
    // labels for username
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
        
    //steppers
    
    @IBOutlet weak var stepperStepper: UIStepper!
    @IBOutlet weak var waterButton: UIStepper!
    @IBOutlet weak var weightButton: UIStepper!
    
    // steppers labels
    @IBOutlet weak var totStepLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var waterLabel: UILabel!
    
    //user photo
    @IBOutlet var userPhoto: UIImageView!
    
    @IBOutlet weak var userPic: UIView!
    
    
    @IBOutlet weak var picB: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tabbar = tabBarController as! mainTabBarViewController
        totStepLabel.text = String(describing: tabbar.stepValue)
        
        
        let SIvc = SignupViewController()
        firstName.text = "\(SIvc.firstname)"
        
        seperators.layer.cornerRadius = 10
        
        // number of steps with incremental stepper
        totStepLabel.text = "2000"
        stepperStepper.stepValue = 500
        stepperStepper.maximumValue = 20000
        weightButton.minimumValue = 0
        
            
        // number for weight with incremental stepper
        weightLabel.text = "50"
        weightButton.value = 50
        weightButton.stepValue = 2
        weightButton.maximumValue = 100
        weightButton.minimumValue = 0
      
        // number for water of glasses drank with incremental stepper
        waterLabel.text = "1"
        waterButton.stepValue = 1
        waterButton.maximumValue = 15
        weightButton.minimumValue = 0
        
       // userPhoto.image = UIImage.init(named: "man1")
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))

        
    }
    @IBAction func logoutUser(_ sender: Any) {
           UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
           self.navigationController?.popToRootViewController(animated: true)
       }
    
    @objc private func didTapAdd() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = PHPickerFilter.images
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present(vc, animated: true)
    }
    
    //choosing a profile picture and viewing it
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
            results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let profile = reading as? UIImage, error == nil else {
                    return
                }
                print(profile)
                
        //for result in results {
        //   result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
         //     if let image = object as? UIImage {
       //          DispatchQueue.main.async {
                    // Use UIImage
       //             print("Selected image: \(image)")
       //          }
       //       }
      //     })///
                
                
                //self.userPhoto.image = UIImage.init(named: "profile")
               // self.userPhoto.image = UIImage.init(named: "result")
                
            }
        }
    }
    
    

    
    // trying to get data from sign up view controller**********
    @IBAction func didTapButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "other") as! SignupViewController
        vc.fnSent = { text in
            self.firstName.text = text
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        totStepLabel.text = String(describing: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let tabbar = tabBarController as! mainTabBarViewController
        tabbar.stepValue = Int(totStepLabel.text!)!
    }
    
    
    //stepper
    @IBAction func stepStepper(_ sender: UIStepper) {
        totStepLabel.text = Int(sender.value).description
    }
    
    @IBAction func weightStepper(_ sender: UIStepper) {
        weightLabel.text = Int(sender.value).description

    }
    
    @IBAction func waterStepper(_ sender: UIStepper) {
        waterLabel.text = Int(sender.value).description

    }
    
    
    
    //move view to the side for the side menu to come out
    @IBAction func menuTapped(_ sender: Any) {
        if menuOut == false {
            leading.constant = 150
            trailing.constant = -150
            menuOut = true
        } else  {
            leading.constant = 0
            trailing.constant = 0
            menuOut = false
        }
        
    }

}
