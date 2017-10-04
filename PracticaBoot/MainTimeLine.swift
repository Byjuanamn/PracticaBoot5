//
//  MainTimeLine.swift
//  PracticaBoot4
//
//  Created by Juan Antonio Martin Noguera on 23/03/2017.
//  Copyright © 2017 COM. All rights reserved.
//

import UIKit
import Firebase

class MainTimeLine: UITableViewController {

    var model: [Posts] = []
    let cellIdentier = "POSTSCELL"
    
     let postsRefence = Database.database().reference(withPath:"posts")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshControl?.addTarget(self, action: #selector(hadleRefresh(_:)), for: UIControlEvents.valueChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadAllPosts()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.postsRefence.removeAllObservers()
    }
    
    @objc func hadleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
    }
    
    // MARK: - Cargar todos los posts publicados
    private func loadAllPosts() {
        postsRefence.queryOrdered(byChild: "isvisible")
            .queryEqual(toValue: true).observe(.value) { (snapShot) in
            var items: [Posts] = []
            
            for item in snapShot.children {
                let post = Posts(snapShot: item as! DataSnapshot)
                items.append(post!)
            }
            
            self.model = items
            self.tableView.reloadData()
        }
    }
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentier, for: indexPath)

        let post = model[indexPath.row]
        cell.textLabel?.text = post.title

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ShowRatingPost", sender: indexPath)
    }


    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowRatingPost" {
            let nextVC = segue.destination as! PostReview
            // aqui pasamos el item selecionado
            let indexPath = sender as? IndexPath
            nextVC.post = model[(indexPath?.row)!]
        }
    }


}
