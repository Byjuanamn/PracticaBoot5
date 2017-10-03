//
//  OnBoardingViewController.swift
//  PracticaBoot
//
//  Created by Juan Martin Noguera on 03/10/2017.
//  Copyright © 2017 COM. All rights reserved.
//

import UIKit
import Firebase

class OnBoardingViewController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTtx: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func createAccount() {
        Auth.auth().createUser(withEmail: emailTxt.text!,
                               password: passwordTtx.text!) { (user, error) in
                                
                                if let error = error {
                                    print("Tenemos un error \(error.localizedDescription)")
                                }
                                
                                if user != nil {
                                    print("Usuario creado -> \(String(describing: user?.email))")
                                }
                                
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func createNewAccountAction(_ sender: Any) {
        self.createAccount()
        
    }
    
}
