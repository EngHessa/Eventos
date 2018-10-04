//
//  SearchTableViewController.swift
//  Eventos
//
//  Created by Deema Alrasheed on 21/01/1440 AH.
//  Copyright © 1440 Ghada Jamal. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {

  
    
    @IBOutlet var findEvent: UITableView!
    let searchController = UISearchController(searchResultsController: nil)

    var eventsArray = [NSDictionary?]()
    var filteredEvents = [NSDictionary?]()
    
    var databaseRef = DatabaseReference?.self

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       let databaseRef = Database.database().reference().root

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        databaseRef.child("users").queryOrdered(byChild: "email").observe(.childAdded, with: {(snapshot)in
            
            self.eventsArray.append(snapshot.value as? NSDictionary)
            
            self.findEvent.insertRows(at: [IndexPath(row:self.eventsArray.count-1,section:0)], with: UITableView.RowAnimation.automatic)
            
        }) {(error) in print(error.localizedDescription)}
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
   }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if searchController.isActive && searchController.searchBar.text != ""{
            return filteredEvents.count
        }
        return self.eventsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let user: NSDictionary?
         if searchController.isActive && searchController.searchBar.text != ""{
            
            user = filteredEvents[indexPath.row]
         }else{
            user = nil
        }
        
        cell.textLabel?.text = user?["email"] as? String
        cell.detailTextLabel?.text = user?["handle"] as? String
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filtereContent(searchText: self.searchController.searchBar.text!)
        
    }
    
    func filtereContent(searchText: String)
    {
        self.filteredEvents = self.eventsArray.filter{ users in
            
            let email = users!["email"] as? String
            
            return (email?.lowercased().contains(searchText.lowercased()))!
        }
        
        tableView.reloadData()
    }

}
