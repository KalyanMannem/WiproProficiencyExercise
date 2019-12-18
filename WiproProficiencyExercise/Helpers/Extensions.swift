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
        loadingView.layer.cornerRadius = 10.0
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

class ScaledHeightImageView: UIImageView{

    override var intrinsicContentSize: CGSize {

        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width

            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio

            return CGSize(width: myViewWidth, height: scaledHeight)
        }
        return CGSize(width: -1.0, height: -1.0)
    }

}

public class ScaleAspectFitImageView : UIImageView{
    // constraint to maintain same aspect ratio as the image
    private var aspectRatioConstraint:NSLayoutConstraint? = nil
    
    required public init?(coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
        self.setup()
    }
    
    public override init(frame:CGRect){
        super.init(frame:frame)
        self.setup()
    }
    
    public override init(image: UIImage!){
        super.init(image:image)
        self.setup()
    }
    
    public override init(image: UIImage!, highlightedImage: UIImage?){
        super.init(image:image,highlightedImage:highlightedImage)
        self.setup()
    }
    
    override public var image: UIImage? {
        didSet {
            self.updateAspectRatioConstraint()
        }
    }
    
    private func setup(){
        self.contentMode = .scaleAspectFit
        self.updateAspectRatioConstraint()
    }
    
    /// Removes any pre-existing aspect ratio constraint, and adds a new one based on the current image
    private func updateAspectRatioConstraint(){
        // remove any existing aspect ratio constraint
        if let c = self.aspectRatioConstraint {
            self.removeConstraint(c)
        }
        self.aspectRatioConstraint = nil
        
        if let imageSize = image?.size, imageSize.height != 0{
            let aspectRatio = imageSize.width / imageSize.height
            let c = NSLayoutConstraint(item: self, attribute: .width,
                                       relatedBy: .equal,
                                       toItem: self, attribute: .height,
                                       multiplier: aspectRatio, constant: 0)
            // a priority above fitting size level and below low
            
            c.priority = UILayoutPriority.defaultLow.rawValue +   UILayoutPriority.fittingSizeLevel
            self.addConstraint(c)
            self.aspectRatioConstraint = c
        }
    }
}

