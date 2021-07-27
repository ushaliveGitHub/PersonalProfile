//
//  ProfileViewModel.swift
//  PersonalProfile
//
//  Created by Usha Natarajan on 7/18/21.
//

import Foundation


class ProfileViewModel: NSObject {
    var items:[ProfileViewModelItem] = []
    
    init(profile:Profile) {
        if let name = profile.data?.fullName,
           let pictureUrl = profile.data?.pictureUrl {
            let nameAndPictureItem = ProfileNameAndPicture(pictureUrl: pictureUrl, userName: name)
            items.append(nameAndPictureItem)
        }
        
        if let about = profile.data?.about {
            let profileAbout = ProfileAbout(about: about)
            items.append(profileAbout)
        }
        
        if let email = profile.data?.email {
            let profileEmail = ProfileEmail(email: email)
            items.append(profileEmail)
        }
        
        if let attributes = profile.data?.profileAttributes, !attributes.isEmpty {
            let profileAttributes = Attributes(attributes: attributes)
            items.append(profileAttributes)
        }
        
        if let friends = profile.data?.friends, !friends.isEmpty {
            let friends = ProfileFriend(friends: friends)
            items.append(friends)
        }
    }
}

enum ProfileViewModelType {
    case nameAndPicture
    case about
    case email
    case friend
    case attribute
    
    var rowOrder: Int {
        switch self {
        case .nameAndPicture: return 0
        case .about: return 1
        case .email: return 2
        case .attribute: return 3
        case .friend: return 4
        }
    }
}

protocol ProfileViewModelItem {
    var type: ProfileViewModelType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}

extension ProfileViewModelItem {
    var rowCount: Int {
        return 1
    }
}


class ProfileNameAndPicture: ProfileViewModelItem {
    
    var type: ProfileViewModelType {
        return ProfileViewModelType.nameAndPicture
    }
    
    var sectionTitle: String {
        return "Main Info"
    }
    
    var pictureUrl: String
    var userName: String
    
    init(pictureUrl: String, userName: String) {
        self.pictureUrl = pictureUrl
        self.userName = userName
    }
}

class ProfileAbout: ProfileViewModelItem {
    var type: ProfileViewModelType {
        return ProfileViewModelType.about
    }
    
    var sectionTitle: String {
        return "Fun facts"
    }
    
    var about: String
    
    init(about: String) {
        self.about = about
    }
}

class ProfileEmail: ProfileViewModelItem {
    var type: ProfileViewModelType {
        return ProfileViewModelType.email
    }
    
    var sectionTitle: String {
        return "Contact"
    }
    var email: String
    
    init(email: String) {
        self.email = email
    }
    
}

class ProfileFriend: ProfileViewModelItem {
    var type: ProfileViewModelType {
        return ProfileViewModelType.friend
    }
    
    var sectionTitle: String {
        return "Friends"
    }
    
    var rowCount: Int {
        return friends.count
    }
    
    var friends: [Friend]
    
    init(friends: [Friend]) {
        self.friends = friends
    }
}

class Attributes: ProfileViewModelItem {
    var type: ProfileViewModelType {
        return ProfileViewModelType.attribute
    }
    
    var sectionTitle: String {
        return "Attributes"
    }
    
    var rowCount: Int {
        return attributes.count
    }
    
    var attributes: [ProfileAttributes]
    
    init(attributes: [ProfileAttributes]) {
        self.attributes = attributes
    }
}
