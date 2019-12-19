//
//  Extensions.swift
//  WiproProficiencyExercise
//
//  Created by Kalyan Mannem on 12/12/19.
//  Copyright © 2019 CompIndia. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    // Stops Loading
    func stopLoading(){
        let someview = self.view.viewWithTag(999)
        UIView.animate(withDuration: 0, delay: 0, options: .transitionFlipFromTop , animations: {
            someview?.layer.opacity = 0.01
        }) { (finished) in
            someview?.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    // Shows Loading
    func startLoading(){
        let loadingView = UIView()
        loadingView.tag = 999
        loadingView.layer.cornerRadius = AppConstants.LOADING_CORNER_RADIUS
        loadingView.backgroundColor = .red
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadingView)
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.color = UIColor.white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(activityIndicator)
        
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Loading..."
        label.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(label)
        
        let visualDict = ["loadingview": loadingView, "label": label, "activityIndicator": activityIndicator,"mainview": self.view]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[mainview]-(<=0)-[loadingview(100)]", options: NSLayoutConstraint.FormatOptions.alignAllCenterY, metrics: nil, views: visualDict as Any as! [String : Any]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[mainview]-(<=0)-[loadingview(100)]", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: visualDict as Any as! [String : Any]))
        loadingView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[loadingview]-(<=0)-[activityIndicator]", options:NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: visualDict as Any as! [String : Any]))
        loadingView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[activityIndicator]", options:[], metrics: nil, views: visualDict as Any as! [String : Any]))
        loadingView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[activityIndicator]-(<=8)-[label]", options:NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: visualDict as Any as! [String : Any]))
        self.view.isUserInteractionEnabled = false
    }
}

extension UIViewController{
    func showAlert(with title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
    }
}
