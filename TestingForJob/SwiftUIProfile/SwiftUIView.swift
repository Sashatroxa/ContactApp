//
//  SwiftUIView.swift
//  TestingForJob
//
//  Created by Александр on 28.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import SwiftUI


struct SwiftUIProfile: View {
    
    var firstName: String
    var lastName: String
    var picture: UIImageView
    
    var body: some View {
        VStack {
            // вообщем, когда я делаю это, то нужно передавать не UIImageView, а UIImage
            //вот это я лох! хахаха прости
            Image(uiImage: picture.image!)
                .clipShape(Circle())
            
            Text(firstName)
                .padding(.top, 10)
            Text(lastName)
        }
    }
}
