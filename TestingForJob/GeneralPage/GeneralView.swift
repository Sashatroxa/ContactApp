//
//  GeneralView.swift
//  TestingForJob
//
//  Created by Александр on 28.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit
import PinLayout

class GeneralView: UIView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let currentWidth = UIScreen.main.bounds.size.width
        tableView.pin.top(safeAreaInsets.top).horizontally().bottom(safeAreaInsets.bottom)
    }
}
