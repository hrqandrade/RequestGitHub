//
//  PullRequestListVC.swift
//  RequestGitHub
//
//  Created by Henrique Silva on 04/02/20.
//  Copyright © 2020 Henrique Silva. All rights reserved.
//

import UIKit
import SkeletonView

class PullRequestListVC: UIViewController {
    
    @IBOutlet var prTableView: UITableView!
    
    var pullRequestModel: [PullRequestModel] = []
    var cellIdentifier = "PullRequestTableViewCell"
    var shouldAnimate = true
    
    lazy var manager = RequestPullRequestManager(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.getPR(login: PullRequestInstance.sharedInstance.login, name: PullRequestInstance.sharedInstance.name)
        configureTableview()
    }
    func showAlertReturn(view: UIViewController) {
        let alert = UIAlertController(title: "Atenção", message: "Erro ao recuperar os dados, por favor tente mais tarde.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (alert) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
}

extension PullRequestListVC: UITableViewDelegate, UITableViewDataSource {
    func configureTableview() {
        prTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        prTableView.delegate = self
        prTableView.dataSource = self
        prTableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldAnimate {
            return 10
        }  else {
            return pullRequestModel.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PullRequestTableViewCell = self.prTableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! PullRequestTableViewCell
        
        cell.setupWith(pr: pullRequestModel, index: indexPath.row, showAnimate: shouldAnimate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PullRequestListVC: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellIdentifier
    }
}

extension PullRequestListVC: RequestPullRequestManagerDelegate {
    func handleError(type: RequestPullRequestError) {
        showAlertReturn(view: self)
    }
    
    func handleSuccess(type: RequestPullRequestSuccess) {
        switch type {
        case .successPR(pr: let pullRequest):
            shouldAnimate = false
            pullRequestModel = pullRequest
            DispatchQueue.main.async{
                self.prTableView.reloadData()
            }
        }
        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: nil)
    }
}
