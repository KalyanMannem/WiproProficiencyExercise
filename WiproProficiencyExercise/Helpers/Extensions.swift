//
//  Extensions.swift
//  WiproProficiencyExercise
//
//  Created by Kalyan Mannem on 12/12/19.
//  Copyright © 2019 CompIndia. All rights reserved.
//

import Foundation
import UIKit

class ScaledHeightImageView: UIImageView
{

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

public class ScaleAspectFitImageView : UIImageView
{
    // constraint to maintain same aspect ratio as the image
    private var aspectRatioConstraint:NSLayoutConstraint? = nil
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder:aDecoder)
        self.setup()
    }
    
    public override init(frame:CGRect)
    {
        super.init(frame:frame)
        self.setup()
    }
    
    public override init(image: UIImage!)
    {
        super.init(image:image)
        self.setup()
    }
    
    public override init(image: UIImage!, highlightedImage: UIImage?)
    {
        super.init(image:image,highlightedImage:highlightedImage)
        self.setup()
    }
    
    override public var image: UIImage? {
        didSet {
            self.updateAspectRatioConstraint()
        }
    }
    
    private func setup()
    {
        self.contentMode = .scaleAspectFit
        self.updateAspectRatioConstraint()
    }
    
    /// Removes any pre-existing aspect ratio constraint, and adds a new one based on the current image
    private func updateAspectRatioConstraint()
    {
        // remove any existing aspect ratio constraint
        if let c = self.aspectRatioConstraint {
            self.removeConstraint(c)
        }
        self.aspectRatioConstraint = nil
        
        if let imageSize = image?.size, imageSize.height != 0
        {
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

