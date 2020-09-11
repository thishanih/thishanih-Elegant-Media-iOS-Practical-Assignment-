//
//  ViewController.swift
//  movies
//
//  Created by Thishan Iroshan on 9/10/20.
//  Copyright © 2020 Thishan Iroshan. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController {
    
    
    @IBOutlet var emailLb1: UILabel!
    @IBOutlet var nameLb1: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    var hotelList: [HotelDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
        downloadJSON {
            self.tableView.reloadData()
        }
        
        
        
        
        
        
        
         let db = Firestore.firestore()
                
                let user = Auth.auth().currentUser
                if let user = user {
                    let uid = user.uid
                    db.collection("users").whereField("uid", isEqualTo: uid)
                        .getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            } else {
                                for document in querySnapshot!.documents {
                                    
                                    //print("\(document.documentID) => \(document.data())")
                                    let firstName = document.get("firstname")
                                    let email = document.get("Email")
                                    
                                    
            
                                    self.nameLb1.text = firstName as? String
                                    self.emailLb1.text = email as? String
                                    
                                    
                                 
                                }
                                
                            }
                    }
                }
        
        
        
        
        
    }
    
    private func config() {
        title = "Hotels"
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue/hotels.json")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print("Request Error: ", error?.localizedDescription)
            }
            
            do {
                guard let data = data else { return}
                let hotelCloudModel = try JSONDecoder().decode(HotelCloudModel.self, from: data)
                self.hotelList.append(contentsOf: hotelCloudModel.data)
                
                DispatchQueue.main.async {
                    completed()
                }
            } catch let error{
                print("Decode Error: ", error)
                return
            }
            
        }.resume()
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hotelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hotel_tv_cell", for: indexPath) as! HotelTVCell
        cell.updateUIWithData(with: self.hotelList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    // pass to data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.hotel = hotelList[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}


