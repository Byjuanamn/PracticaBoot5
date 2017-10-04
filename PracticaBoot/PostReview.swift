//
//  PostReview.swift
//  PracticaBoot4
//
//  Created by Juan Antonio Martin Noguera on 23/03/2017.
//  Copyright © 2017 COM. All rights reserved.
//

import UIKit
import Firebase


class PostReview: UIViewController {

    @IBOutlet weak var rateSlider: UISlider!
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var postTxt: UITextField!
    @IBOutlet weak var titleTxt: UITextField!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    let storage = Storage.storage()
    var taskDownnLoad: StorageDownloadTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.downloadObject()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rateAction(_ sender: Any) {
        print("\((sender as! UISlider).value)")
    }

    @IBAction func ratePost(_ sender: Any) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.taskDownnLoad?.removeAllObservers()
    }
    
    // MARK: Descarga
    private func downloadObject() {
        
        // url temporan
        let urlTemp = "https://firebasestorage.googleapis.com/v0/b/fbdata-63fb3.appspot.com/o/imgposts%2FACEA3400-B9AD-4422-85F7-24A6C9FBDEC7.jpg?alt=media&token=194b9d30-7d43-4681-847a-d656a7624513"
        let storageRef = storage.reference(forURL: urlTemp)
        
//        let fileRef = storageRef.child("ACEA3400-B9AD-4422-85F7-24A6C9FBDEC7.jpg")
        
        taskDownnLoad = storageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            if error != nil {
                print("Error en descarga")
                return
            }
            if data != nil {
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.imagePost.image = image
                }
            }
            }
            
        taskDownnLoad?.observe(.progress) { (snapshot) in
           
            let percentComplete = 100.0 *
                Double((snapshot.progress?.completedUnitCount)!) / Double((snapshot.progress?.totalUnitCount)!)
            self.progressView.progress = Float(percentComplete)
        }
        
        taskDownnLoad?.observe(.success) { (snapshot) in
            self.progressView.progress = 0.0
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

}
