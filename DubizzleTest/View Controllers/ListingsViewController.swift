//
//  ViewController.swift
//  DubizzleTest
//
//  Created by Saqib Bhatti on 05/12/2020.
//

import UIKit

class ListingsViewController: UIViewController {

    private var listVM: ListingsViewModel!
    let listingsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callListingsAPI()
        
        view.backgroundColor = .white
        view.addSubview(listingsTableView)
        
        listingsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        listingsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        listingsTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        listingsTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        listingsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        listingsTableView.register(ListingTableViewCell.self, forCellReuseIdentifier: "listCell")
        
        navigationItem.title = "Listings"
    }
    
    func callListingsAPI() {
        self.startBallsLoader()
        
        let url = URL(string: BASE_URL)!
        WebService().getListings(url: url) { listings in
            self.stopBallsLoader()
            
            if let listings = listings {
                self.listVM = ListingsViewModel(listings: listings)
                
                DispatchQueue.main.async {
                    self.listingsTableView.dataSource = self
                    self.listingsTableView.delegate = self
                    self.listingsTableView.reloadData()
                }
            }
        }
    }
}


extension ListingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListingTableViewCell

        let listingVM = self.listVM.listingAtIndex(indexPath.row)
        cell.list = listingVM

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selected_item = self.listVM.listingAtIndex(indexPath.row)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailVC.arrayOfListData = NSMutableArray()
        detailVC.arrayOfListData.insert(selected_item.name, at: 0)
        detailVC.arrayOfListData.insert(selected_item.price, at: 1)
        
        let formattedDateString = Helper.getFormattedDate(selected_item.created_at)
        detailVC.arrayOfListData.insert(formattedDateString ?? "", at: 2)
        
        detailVC.imgString = selected_item.image_urls[0]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
