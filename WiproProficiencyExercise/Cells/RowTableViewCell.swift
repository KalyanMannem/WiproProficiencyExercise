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

class RowTableViewCell: UITableViewCell{
    private let placeholder = "placeholder"
    private let stackViewSpacing: CGFloat = 10.0
    var item : Row? {
        didSet {
            rowTitleLabel.text = item?.title
            rowDescriptionLabel.text = item?.rowDescription
            if let  imageUrl = URL(string: item?.imageHref ?? ""){
                rowImage.kf.indicatorType = .activity
                rowImage.kf.setImage(
                    with: imageUrl,
                    placeholder: UIImage(named: placeholder),
                    options: [
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                ])
            }else{
                rowImage.image = nil
            }
        }
    }
    
    private let rowTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        return label
    }()
    
    
    private let rowDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let rowImage: ScaleAspectFitImageView = {
        let imageView = ScaleAspectFitImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        let stackView = UIStackView(arrangedSubviews: [rowImage, rowTitleLabel, rowDescriptionLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = stackViewSpacing
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
