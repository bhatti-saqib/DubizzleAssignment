//
//  Extensions.swift
//  DubizzleTest
//
//  Created by Saqib Bhatti on 05/12/2020.
//
/*
 https://blewjy.github.io/ios/swift/4/basic/2019/02/27/image-caching-in-swift-4.html
 */

import Foundation
import UIKit
import NVActivityIndicatorView

extension UIViewController {
    
    func startBallsLoader() {
        DispatchQueue.main.async(execute: {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(ACTIVITY_DATA, NVActivityIndicatorView.DEFAULT_FADE_IN_ANIMATION)
        })
    }
    
    func stopBallsLoader(){
        DispatchQueue.main.async(execute: {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(NVActivityIndicatorView.DEFAULT_FADE_OUT_ANIMATION)
        })
    }
}

var imageCache = NSCache<AnyObject, AnyObject>()
var activityView: UIActivityIndicatorView?

extension UIImageView {
    
    func loadImage(urlString: String) {
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        self.showActivityIndicator()
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Couldn't download image: ", error)
                return
            }
            
            guard let data = data else { return }
            let image = UIImage(data: data)
            imageCache.setObject(image as AnyObject, forKey: urlString as AnyObject)
            
            DispatchQueue.main.async {
                self.hideActivityIndicator()
                self.image = image
            }
        }.resume()
    }
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .gray)
        activityView?.center = self.center
//        self.addSubview(activityView!)
        activityView?.startAnimating()
    }

    func hideActivityIndicator() {
        if (activityView != nil) {
            activityView?.stopAnimating()
        }
    }
}


extension Date {
    
    static func getFormattedDate(_ dateString: String?) -> String? {
        let dateFormat = DateFormatter()
        
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let date = dateFormat.date(from: dateString ?? "")

        dateFormat.dateFormat = "EEEE MMMM d, YYYY"
        var dateStr: String? = nil
        if let date = date {
            dateStr = dateFormat.string(from: date)
            return dateStr
        }
        else {
            return nil
        }
    }
}
