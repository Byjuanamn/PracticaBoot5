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
        
        if self.isUserLogin() {
            // saltar al siguiente viewController
//            self.nextViewControllerSegue()
            
        } else {
            self.osbserverUserActivity()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if handler != nil {
            Auth.auth().removeStateDidChangeListener(handler!)
        }
    }

    private func nextViewControllerSegue() {
        self.performSegue(withIdentifier: "GotoMain", sender: nil)
    }
    
    private func osbserverUserActivity() {
        handler = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if user != nil {
                print("Usuario creado -> \(String(describing: user?.uid))")
            }
        }
    }
    private func isUserLogin() -> Bool {
        
        if let user = Auth.auth().currentUser {
            return true
        }
        return false
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
    
    private func login() {
        
        Auth.auth().signIn(withEmail: emailTxt.text!, password: passwordTtx.text!) { (user, error) in
            if let error = error {
                print("Tenemos un error \(error.localizedDescription)")
            }
            
            if user != nil {
                self.nextViewControllerSegue()
            }
        }
    }
    
    private func logout() {
        try! Auth.auth().signOut()
    }
    
    private func resetUserPassword() {
        
        if self.isUserLogin() {
            let user = Auth.auth().currentUser
            Auth.auth().sendPasswordReset(withEmail: (user?.email)!, completion: { (error) in
                if error != nil {
                    print(error?.localizedDescription)
                }
            })
            
            
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
    @IBAction func resetPwdAction(_ sender: Any) {
        self.resetUserPassword()
    }
    @IBAction func createNewAccountAction(_ sender: Any) {
        self.createAccount()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        self.login()
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        self.logout()
    }
    
}




















