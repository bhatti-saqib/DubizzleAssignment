//
//  WebService.swift
//  DubizzleTest
//
//  Created by Saqib Bhatti on 05/12/2020.
//

import Foundation

final class WebService {
    
    func getListings(url: URL, completion: @escaping ([Listing]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            else if let data = data {
                let listings = try? JSONDecoder().decode(ListingsList.self, from: data)
                if let listings = listings {
                    completion(listings.results)
                }
            }
            else {
                completion(nil)
            }
        }.resume()
    }
    
    
    func imageFrom(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
            }
            else if let data = data {
                let image = UIImage(data: data)
                completion(image, nil)
            }
            
        }.resume()
    }
}
