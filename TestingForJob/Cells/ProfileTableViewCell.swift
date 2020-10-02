//
//  ProfileTableViewCell.swift
//  TestingForJob
//
//  Created by Александр on 28.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    var imagePicture = UIImageView()
    var nameLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(imagePicture)
        imagePicture.backgroundColor = .lightGray
        
        
        addSubview(nameLabel)
        nameLabel.textColor = UIColor(red: 0.496, green: 0.496, blue: 0.496, alpha: 1)
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nameLabel.textAlignment = .left
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupUI()
    }
    
    private func setupUI() {
        imagePicture.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imagePicture.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imagePicture.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            imagePicture.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imagePicture.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: -20),
            imagePicture.widthAnchor.constraint(equalToConstant: 100),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ])
        
        selectionStyle = .none
        imagePicture.layer.cornerRadius = 50
        imagePicture.clipsToBounds = true
    }
    
    func configure(profile: Profile) {
        imagePicture.downloadImage(from: profile.picture)
        nameLabel.text = "\(profile.firstName ?? "") \(profile.lastName ?? "")"
    }
}

