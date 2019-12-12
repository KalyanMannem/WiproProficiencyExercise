//
//  Utility.swift
//  WiproProficiencyExercise
//
//  Created by Kalyan Mannem on 12/12/19.
//  Copyright © 2019 CompIndia. All rights reserved.
//

import Foundation
import Reachability

class Utility: NSObject
{
    class func isConnectedtoNetwork() -> Bool
    {
        let reachability = try! Reachability()
        return reachability.connection != .unavailable
    }
    
    class func showAlert(title:String? = nil, message:String, alertActions:[String], style:UIAlertController.Style = UIAlertController.Style.alert, alertCompletion:((UIAlertAction)-> Void)? = nil)
    {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: style)
        alertActions.forEach({
            let is_destructive = $0 == "Cancel"
            let alertAction = UIAlertAction.init(title: $0, style:is_destructive ? .destructive : .default, handler: alertCompletion)
            alertController.addAction(alertAction)
        })
        if let visibleViewController = (window.rootViewController as? UINavigationController)?.visibleViewController {
            visibleViewController.present(alertController, animated: true, completion: nil)
            return
        }
        if let presentedViewController = window.rootViewController?.presentedViewController {
            presentedViewController.present(alertController, animated: true, completion: nil)
            return
        }
        window.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
