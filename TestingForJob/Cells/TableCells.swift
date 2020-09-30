//
//  TableCells.swift
//  TestingForJob
//
//  Created by Александр on 28.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit
import PinLayout

class TableCell: UITableViewCell {
    
    var imagePicture = UIImageView()
    var firstName = UILabel()
    var lastName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(imagePicture)
        imagePicture.backgroundColor = .lightGray
        
        
        addSubview(firstName)
        firstName.textColor = UIColor(red: 0.496, green: 0.496, blue: 0.496, alpha: 1)
        firstName.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        firstName.textAlignment = .left
        
        addSubview(lastName)
        lastName.textColor = UIColor(red: 0.496, green: 0.496, blue: 0.496, alpha: 1)
        lastName.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imagePicture.pin.vertically(5).left(20).width(100)
        firstName.pin.after(of: imagePicture, aligned: .center).marginLeft(20).top(20).sizeToFit()
        lastName.pin.after(of: firstName, aligned: .center).marginLeft(6).top(20).sizeToFit()
    }
}

