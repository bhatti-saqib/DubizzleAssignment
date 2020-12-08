//
//  ContactTableViewCell.swift
//  DubizzleTest
//
//  Created by Saqib Bhatti on 05/12/2020.
//

import UIKit

class ListingTableViewCell: UITableViewCell {
    
    var list: ListViewModel? {
        didSet {
            guard let listItem = list else {return}
            let name = listItem.name
            
            profileImageView.loadImage(urlString: listItem.image_urls[0], placeHolderImage: "Placeholder")
            
            nameLabel.text = name
            
            let price = listItem.price
            priceLabel.text = " \(price)"
        }
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let profileImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        return img
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .systemRed
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(profileImageView)
        containerView.addSubview(priceLabel)
        containerView.addSubview(nameLabel)
        self.contentView.addSubview(containerView)
        
        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant: 10).isActive = true
        profileImageView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant: -10).isActive = true
//        profileImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:150).isActive = true
        
        containerView.topAnchor.constraint(equalTo:self.profileImageView.bottomAnchor, constant:10).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant: -10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:60).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo:self.priceLabel.bottomAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
}
