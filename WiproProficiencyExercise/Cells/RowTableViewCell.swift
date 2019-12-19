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
                rowImageView.kf.indicatorType = .activity
                rowImageView.kf.setImage(
                    with: imageUrl,
                    placeholder: UIImage(named: placeholder),
                    options: [
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                ])
            }else{
                rowImageView.image = UIImage(named: placeholder)
            }
        }
    }
    
    private let rowTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont(name: "HelveticaNeue", size: 19.0)
        label.textAlignment = .left
        return label
    }()
    
    private let rowDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont(name: "HelveticaNeue", size: 15.0)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let rowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5.0
        imageView.backgroundColor = UIColor.init(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0)

        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        
        self.selectionStyle = .none

        rowImageView.translatesAutoresizingMaskIntoConstraints = false
        rowImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        rowImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [rowTitleLabel, rowDescriptionLabel])
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.axis = .vertical
        stackView.spacing = 10
        
        let horizantalStackView = UIStackView(arrangedSubviews: [rowImageView, stackView])
        horizantalStackView.alignment = .top
        horizantalStackView.distribution = .fill
        horizantalStackView.axis = .horizontal
        horizantalStackView.spacing = 10
        
        contentView.addSubview(horizantalStackView)
        
        horizantalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizantalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        horizantalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        horizantalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        horizantalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
