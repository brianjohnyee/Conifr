//
//  UserModel.swift
//  Conifr
//
//  Created by Sid Verma on 2/6/18.
//  Copyright © 2018 Sid Verma. All rights reserved.
//

import Foundation


class User {
    
    //MARK: Properties
    
    var uid: String
    var email: String
    var name: String
    var college: String
    var university: String
    var rank: String
    var trips: [Trip]
    
    //MARK: Initialization
    
    init?(uid: String, email: String, name: String, college: String, university:String, rank: String, trips: [Trip]) {
        
        //Initialization should fail if distance is less than zero or total C02 emission is less than 0 or mode of transportation is empty or start/end time is less than or equal to zero
        if uid.isEmpty || email.isEmpty || name.isEmpty || college.isEmpty || university.isEmpty {
            return nil
        }
        
        self.uid = uid
        self.email = email
        self.name = name
        self.college = college
        self.university = university
        self.rank = rank
        self.trips = trips
        
    }
    
}
