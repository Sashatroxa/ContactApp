//
//  SwiftUIView.swift
//  TestingForJob
//
//  Created by Александр on 28.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import SwiftUI


struct SwiftUIView: View {
    
    var firstName:String
    var lastName:String
    var picture:String
    
    var body: some View {
        VStack {
            RemoteImage(url: self.picture)
                .clipShape(Circle())
            
            Text(firstName)
                .padding(.top, 10)
            Text(lastName)
        }
    }
}
