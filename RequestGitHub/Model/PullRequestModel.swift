//
//  PullRequestModel.swift
//  RequestGitHub
//
//  Created by Henrique Silva on 03/02/20.
//  Copyright © 2020 Henrique Silva. All rights reserved.
//

import UIKit

public struct PullRequestModel: Codable {
        let title : String?
        let user : User?
        let body : String?
        let created_at : String?

        enum CodingKeys: String, CodingKey {

            case title = "title"
            case user = "user"
            case body = "body"
            case created_at = "created_at"
        }

    public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            title = try values.decodeIfPresent(String.self, forKey: .title)
            user = try values.decodeIfPresent(User.self, forKey: .user)
            body = try values.decodeIfPresent(String.self, forKey: .body)
            created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        }

    }

// MARK: - User
struct User : Codable {
    let login : String?
    let avatar_url : String?

    enum CodingKeys: String, CodingKey {

        case login = "login"
        case avatar_url = "avatar_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        login = try values.decodeIfPresent(String.self, forKey: .login)
        avatar_url = try values.decodeIfPresent(String.self, forKey: .avatar_url)
    }

}


public class PullRequestInstance {
     public var name: String!
     public var login: String!
    private static var _sharedInstance: PullRequestInstance?

       public static var sharedInstance: PullRequestInstance {
           guard let instance = _sharedInstance else {
               let newInstance = PullRequestInstance()
               _sharedInstance = newInstance
               return newInstance
           }
           return instance
       }

       init() {}
    
    public func setInfo(name: String, login: String) {
        PullRequestInstance.sharedInstance.name = name
        PullRequestInstance.sharedInstance.login = login
    }
    
    public func removeInfo(){
        PullRequestInstance.sharedInstance.name = ""
        PullRequestInstance.sharedInstance.login = ""
    }
}

