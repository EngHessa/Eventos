//
//  HomePageViewController.swift
//  Eventos
// hessa
//  Created by Ghada Nasser on 12 محرم، 1440 هـ.
//  Copyright © 1440 هـ Ghada Jamal. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomePageViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    
       var searchURL = String()
     //var myString = String()
    override func viewDidLoad() {
        super.viewDidLoad()

     //   Hi.text = myString
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
    }
    
   /* func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let keywords = searchBar.text
        let finalKeywords = keywords?.replacingOccurrences(of: " ", with: "+")
        
        
        searchURL = "https://api.spotify.com/v1/search?q=\(finalKeywords!)&type=track"
        
        print(searchURL)
        
        callAlamo(url: searchURL)
        self.view.endEditing(true)
        
    }
    
    let ref = Database.database().reference().child("users").child("Klx0N4pxsBHGVkhYuY0")
    
    
    if let value = snapshot.value as? Dictionary<String,Any> {
    
    // There is data, so it exists
    
    print(value)
    
    } else {
    
    // There is no data, so it doesn't exist
    }
    }) */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
