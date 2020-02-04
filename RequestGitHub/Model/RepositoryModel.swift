//
//  RepositoryModel.swift
//  RequestGitHub
//
//  Created by Henrique Silva on 02/02/20.
//  Copyright © 2020 Henrique Silva. All rights reserved.
//

import UIKit

public class RepositoryModel: Codable {
    public var totalCount: Int?
    public var incompleteResults: Bool?
    public var items: [Item]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount
        case incompleteResults
        case items
    }

     required init(totalCount: Int?, incompleteResults: Bool?, items: [Item]?) throws{
        self.totalCount = totalCount
        self.incompleteResults = incompleteResults
        self.items = items
    }
}

// MARK: - Item
public class Item: Codable {
    var name, fullName: String?
    var owner: Owner?
    var description: String?
    var size, stargazersCount, forks: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case owner
        case description
        case size
        case stargazersCount = "stargazers_count"
        case forks
    }

    init(name: String?, fullName: String?, owner: Owner?, description: String?, size: Int?, stargazersCount: Int?, forks: Int?) {
        self.name = name
        self.fullName = fullName
        self.owner = owner
        self.description = description
        self.size = size
        self.stargazersCount = stargazersCount
        self.forks = forks
    }
}

// MARK: - Owner
class Owner: Codable {
    var login: String?
    var id: Int?
    var nodeID: String?
    var avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID
        case avatarURL = "avatar_url"
    }

    init(login: String?, id: Int?, nodeID: String?, avatarURL: String?) {
        self.login = login
        self.id = id
        self.nodeID = nodeID
        self.avatarURL = avatarURL
    }
}
