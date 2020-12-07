//
//  Listing.swift
//  DubizzleTest
//
//  Created by Saqib Bhatti on 05/12/2020.
//

import Foundation

struct ListingsList: Decodable {
    let results: [Listing]
}
struct Listing: Decodable {
    let created_at: String?
    let price: String?
    let name: String?
    let image_urls: [String]?
}
