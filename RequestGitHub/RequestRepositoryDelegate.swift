//
//  RequestDelegate.swift
//  RequestGitHub
//
//  Created by Henrique Silva on 02/02/20.
//  Copyright © 2020 Henrique Silva. All rights reserved.
//

import UIKit

public enum RequestRepositorySuccess {
    case successRepo(repo: RepositoryModel)
}

public enum RequestRepositoryError {
    case error
}

public protocol RequestRepositoryManagerDelegate: AnyObject {
    func handleError(type: RequestRepositoryError)
    func handleSuccess(type: RequestRepositorySuccess)
}

public class RequestRepositoryManager {
    
    internal weak var delegate: RequestRepositoryManagerDelegate?
    
    public init(delegate: RequestRepositoryManagerDelegate) {
        self.delegate = delegate
    }
    
    public func getRepository(page: Int){
        let url = URL(string: "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=\(page)")!
        var request  = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in

            if error != nil {
                self.delegate?.handleError(type: .error)
                return
            }

            guard let jsonData = data else {
                self.delegate?.handleError(type: .error)
                return
            }
            
            guard let repositoryModel = try? JSONDecoder().decode(RepositoryModel.self, from: jsonData), repositoryModel.items != nil else {
                self.delegate?.handleError(type: .error)
                return
            }
            self.delegate?.handleSuccess(type: .successRepo(repo: repositoryModel))
        }.resume()
    }
    
}
