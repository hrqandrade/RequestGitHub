//
//  RequestPullRequestDelegate.swift
//  RequestGitHub
//
//  Created by Henrique Silva on 04/02/20.
//  Copyright © 2020 Henrique Silva. All rights reserved.
//

import Foundation

public enum RequestPullRequestSuccess {
    case successPR(pr: [PullRequestModel])
}

public enum RequestPullRequestError {
    case error
}

public protocol RequestPullRequestManagerDelegate: AnyObject {
    func handleError(type: RequestPullRequestError)
    func handleSuccess(type: RequestPullRequestSuccess)
}

public class RequestPullRequestManager {
    
    internal weak var delegate: RequestPullRequestManagerDelegate?
    
    public init(delegate: RequestPullRequestManagerDelegate) {
        self.delegate = delegate
    }
    
    
    public func getPR(login: String,name: String){
        let url = URL(string: "https://api.github.com/repos/\(login)/\(name)/pulls")!
        var request  = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in

            let jsonDecoder = JSONDecoder()
            
            if error != nil {
                self.delegate?.handleError(type: .error)
                return
            }

            guard let jsonData = data else {
                self.delegate?.handleError(type: .error)
                return
            }
            
            do  {
                let pullRequestModel = try jsonDecoder.decode([PullRequestModel].self, from: jsonData)
                if pullRequestModel.count == 0 {
                    self.delegate?.handleError(type: .error)
                } else {
                    self.delegate?.handleSuccess(type: .successPR(pr: pullRequestModel))
                }
               
            } catch {
             self.delegate?.handleError(type: .error)
            }
        }.resume()
    }

    
}


extension Data
{
    func printJSON()
    {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8)
        {
            print(JSONString)
        }
    }
}

extension URL {
    func asyncDownload(completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()) {
        URLSession.shared
            .dataTask(with: self, completionHandler: completion)
            .resume()
    }
}
