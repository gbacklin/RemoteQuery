//
//  Person.swift
//  RemoteQuery
//
//  Created by Gene Backlin on 12/24/20.
//

import Foundation

struct Person: Decodable, Identifiable {
    public var id: String
    public var Firstname: String
    public var Lastname: String
    public var Hometown: String
    public var Age: String
    public var Job: String

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case Firstname = "Firstname"
        case Lastname = "Lastname"
        case Hometown = "Hometown"
        case Age = "Age"
        case Job = "Job"
    }
}
