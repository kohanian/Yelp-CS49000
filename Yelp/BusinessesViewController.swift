//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import AlamofireImage

class YelpItem: UITableViewCell {
    
    @IBOutlet weak var businessMileage: UILabel!
    @IBOutlet weak var businessReviews: UILabel!
    @IBOutlet weak var businessRatingsImageView: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var businessAddressLabel: UILabel!
    @IBOutlet weak var businessTagLabel: UILabel!
    
}

class BusinessesViewController: UIViewController, UITableViewDataSource,
UITableViewDelegate, UISearchBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(businesses == nil) {
            return 0;
        }
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YelpItem") as! YelpItem
        let bussines = businesses[indexPath.item]
        cell.businessNameLabel.text = bussines.name
        if(bussines.imageURL != nil) {
            cell.businessImageView.af_setImage(withURL: bussines.imageURL!)
        }
        if(bussines.ratingImageURL != nil) {
            cell.businessRatingsImageView.af_setImage(withURL: bussines.ratingImageURL!)
        }
        cell.businessReviews.text = (bussines.reviewCount?.stringValue)! + " Reviews"
        cell.businessTagLabel.text = bussines.categories
        cell.businessAddressLabel.text = bussines.address
        cell.businessMileage.text = bussines.distance
        
        
        
        return cell;
    }
    
    
    @IBOutlet weak var businessTableView: UITableView!
    var businesses: [Business]!
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar = UISearchBar()
        searchBar.placeholder = "Restraunts"
        searchBar.sizeToFit()
        searchBar.backgroundColor = UIColor.red
        navigationItem.titleView = searchBar
        businessTableView.dataSource = self
        businessTableView.delegate = self
        searchBar.delegate = self
        searchBar.tintColor = UIColor.red
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
                self.businessTableView.reloadData()
            }
            
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: Error!) -> Void in
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        Business.searchWithTerm(term: searchText, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
                self.businessTableView.reloadData()
            }
            
        }
        )
       
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
