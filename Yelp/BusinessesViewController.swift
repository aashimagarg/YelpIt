//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    @IBOutlet weak var tableView: UITableView!
    var businesses: [Business]!
    var filtered: [Business]!
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.sizeToFit()

        self.searchBar.delegate = self
        
        navigationItem.titleView = searchBar
        
        searchDisplayController?.displaysSearchBarInNavigationBar = true

        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })

/* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let businesses = businesses {
        if filtered != nil {
            return filtered!.count
        }
            return businesses.count
        }
            
        else {
            return 0
        }
        }
    
    
    
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        if filtered != nil {
            cell.business = filtered[indexPath.row]
        }
        else {
            cell.business = businesses[indexPath.row]

        }
        
        return cell
    }
    
        func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                filtered = nil
            }
            else {
                filtered = businesses!.filter({(business: Business) -> Bool in
                    if (business.name)!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                        return true
                    }
                    else {
                        return false
                    }
                })
            }
            self.tableView.reloadData()
        }
        


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
