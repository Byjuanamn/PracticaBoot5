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
    
    var handler: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        handler = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if user != nil {
                print("Usuario creado -> \(String(describing: user?.uid))")
//                self.performSegue(withIdentifier: "GotoMain", sender: nil)
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handler!)
    }


    private func createAccount() {
        Auth.auth().createUser(withEmail: emailTxt.text!,
                               password: passwordTtx.text!) { (user, error) in
                                
                                if let error = error {
                                    print("Tenemos un error \(error.localizedDescription)")
                                }
                                
                                if user != nil {
                                    print("Usuario creado -> \(String(describing: user?.email))")
                                    // validar el mail del nuevo usuario
                                    
                                    user?.sendEmailVerification(completion: { (error) in
                                        if let error = error {
                                            print(error.localizedDescription)
                                        }
                                    })
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
