//
//  ListingViewModel.swift
//  DubizzleTest
//
//  Created by Saqib Bhatti on 05/12/2020.
//

import Foundation

struct ListingsViewModel: Decodable {
    let listings:[Listing]
}

extension ListingsViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.listings.count
    }
    
    func listingAtIndex(_ index: Int) -> ListViewModel {
        let listing = listings[index]
        return ListViewModel(listing)
    }
}



struct ListViewModel: Decodable {
    private let listing: Listing
}

extension ListViewModel {
    init(_ listing: Listing) {
        self.listing = listing
    }
}

extension ListViewModel {
    var created_at: String {
        return self.listing.created_at ?? ""
    }
    
    var price: String {
        return self.listing.price ?? ""
    }
    
    var name: String {
        return self.listing.name ?? ""
    }
    
    var image_urls: [String] {
        return self.listing.image_urls ?? []
    }
}
