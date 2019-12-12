//
//  RowTableViewCell.swift
//  WiproProficiencyExercise
//
//  Created by Kalyan Mannem on 12/12/19.
//  Copyright © 2019 CompIndia. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class RowTableViewCell: UITableViewCell
{
    var item : Row? {
        didSet {
            rowTitleLabel.text = item?.title
            rowDescriptionLabel.text = item?.rowDescription
            if let  imageUrl = URL(string: item?.imageHref ?? "")
            {
                rowImage.kf.indicatorType = .activity
                rowImage.kf.setImage(
                    with: imageUrl,
                    placeholder: UIImage(named: "placeholder"),
                    options: [
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                ])
            }
            else
            {
                rowImage.image = nil
            }
        }
    }
    
    private let rowTitleLabel : UILabel = {
        let lbl = UILabel()
        if #available(iOS 13.0, *) {
            lbl.textColor = .label
        } else {
            // Fallback on earlier versions
            lbl.textColor = .darkText

        }
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    private let rowDescriptionLabel : UILabel = {
        let lbl = UILabel()
        if #available(iOS 13.0, *)
        {
            lbl.textColor = .label
        }
        else
        {
            // Fallback on earlier versions
            lbl.textColor = .darkText
        }
        lbl.font = UIFont.preferredFont(forTextStyle: .body)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let rowImage : ScaleAspectFitImageView = {
        let imgView = ScaleAspectFitImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
  
        self.selectionStyle = .none
        if #available(iOS 13.0, *)
        {
            self.backgroundColor = .systemBackground
        }
        else
        {
            // Fallback on earlier versions
            self.backgroundColor = .white
        }
        let stackView = UIStackView(arrangedSubviews: [rowImage, rowTitleLabel, rowDescriptionLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
