//
//  DataManager.swift
//  PersonalProfile
//
//  Created by Usha Natarajan on 7/18/21.
//

import Foundation

class DataManager {

    
    private var profileFileName: String = "Person"
    private var fileType: String  = "json"
    var completion: ((Result<Profile, Error>)->Void)?
    
    func getProfile()  {
        let profileError = NSError(domain: "Person", code: -999, userInfo: [NSLocalizedDescriptionKey : "Error fetching data"])
        let bundle = Bundle(for: DataManager.self)
        guard let path = bundle.path(forResource: profileFileName, ofType: fileType) else {
            completion?(.failure(profileError))
            return
        }
        do {
         let data = try  Data(contentsOf: URL(fileURLWithPath: path), options: [])
            guard let profile = toProfile(data) else {
                completion?(.failure(profileError))
                return
            }
            completion?(.success(profile))
        } catch let error {
            debugPrint("Unable to read contents of file")
            completion?(.failure(error))
        }
    }
    
    private func toProfile(_ data: Data?) -> Profile? {
        guard let data = data else { return nil }
        
        do {
            let profile = try JSONDecoder().decode(Profile.self, from: data)
            return profile
        } catch _ {
            debugPrint("Json parsing error")
            return nil
        }
    }
}
