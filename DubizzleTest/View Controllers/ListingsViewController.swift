//
//  ViewController.swift
//  DubizzleTest
//
//  Created by Saqib Bhatti on 05/12/2020.
//

import UIKit

class ListingsViewController: UIViewController {

    private var listVM: ListingsViewModel!
    let contactsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callListingsAPI()
        
        view.backgroundColor = .white
        view.addSubview(contactsTableView)
        
        contactsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        contactsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        contactsTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        contactsTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        contactsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contactsTableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "contactCell")
        
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
                    self.contactsTableView.dataSource = self
                    self.contactsTableView.delegate = self
                    self.contactsTableView.reloadData()
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

        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell

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
        detailVC.arrayOfListData.insert(selected_item.created_at, at: 2)
        detailVC.imgString = selected_item.image_urls[0]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
