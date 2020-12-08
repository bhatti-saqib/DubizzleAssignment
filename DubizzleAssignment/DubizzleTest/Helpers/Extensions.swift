//
//  Extensions.swift
//  DubizzleTest
//
//  Created by Saqib Bhatti on 05/12/2020.
//

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

