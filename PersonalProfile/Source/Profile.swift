//
//  Profile.swift
//  PersonalProfile
//
//  Created by Usha Natarajan on 7/17/21.
//

import Foundation

enum DataType {
    case profile
    case friend
    case attribute
}

class Profile: Codable {
    var data: profileData?
    var error: Int?
    var message: String?
}

class profileData: Codable {
    var id: Int?
    var fullName: String?
    var pictureUrl: String?
    var email: String?
    var about: String?
    var friends:[Friend]?
    var profileAttributes:[ProfileAttributes]?
}

class Friend: Codable {
    var id: Int?
    var name: String?
    var pictureUrl: String?
}

class ProfileAttributes: Codable {
    var id: Int?
    var key: String?
    var value: String?
}
