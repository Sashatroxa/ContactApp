//
//  Data.swift
//  TestingForJob
//
//  Created by Александр on 28.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import Foundation
import UIKit

struct AllData : Codable {
    
    var data: [Profile]?
    var total:Int
    var page:Int
    var limit:Int
    var offset:Int
    
    init() {
        self.data = nil
        self.total = 0
        self.page = 0
        self.limit = 0
        self.offset = 0
    }
    
    init(data: [Profile]? = nil, total: Int, page: Int, limit: Int, offset: Int) {
        self.data = data
        self.total = total
        self.page = page
        self.limit = limit
        self.offset = offset
    }
}

struct Profile : Codable {
    let id: String?
    let title: String?
    let lastName: String?
    let firstName: String?
    let email: String?
    let picture: String?
}
