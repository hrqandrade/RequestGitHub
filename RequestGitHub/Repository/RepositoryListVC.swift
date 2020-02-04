//
//  ViewController.swift
//  RequestGitHub
//
//  Created by Henrique Silva on 02/02/20.
//  Copyright © 2020 Henrique Silva. All rights reserved.
//

import UIKit
import SkeletonView

class RepositoryListVC: UIViewController {
    
    @IBOutlet var repoTableView: UITableView!
    
    var repositoryModel: [Item] = []
    var pageCount = 1
    var lastItem = 0
    var cellIdentifier = "RepositoryTableViewCell"
    var shouldAnimate = true
    
    lazy var manager = RequestRepositoryManager(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.getRepository(page: pageCount)
        configureTableview()
    }
   
}

extension RepositoryListVC: UITableViewDelegate, UITableViewDataSource {
    func configureTableview() {
        repoTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        repoTableView.delegate = self
        repoTableView.dataSource = self
        repoTableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldAnimate {
            return 10
        }  else {
            lastItem = repositoryModel.count
            return repositoryModel.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepositoryTableViewCell = self.repoTableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! RepositoryTableViewCell
        cell.setupWith(repo: repositoryModel, index: indexPath.row, showAnimate: shouldAnimate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == lastItem-1{
            pageCount += 1
            manager.getRepository(page: pageCount)
            repoTableView.tableFooterView = setActivity(viewWidth: repoTableView)
            repoTableView.tableFooterView?.isHidden = false
            repoTableView.tableFooterView?.isAccessibilityElement = false
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let login = repositoryModel[indexPath.row].owner?.login, let name = repositoryModel[indexPath.row].name  else {
            showAlert(view: self)
            return
        }
        PullRequestInstance.sharedInstance.setInfo(name: name, login: login)
        self.performSegue(withIdentifier: "seguePullRequestVC", sender: nil)
    }
}

extension RepositoryListVC: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellIdentifier
    }
}

extension RepositoryListVC: RequestRepositoryManagerDelegate {
    func handleError(type: RequestRepositoryError) {
       showAlert(view: self)
    }
    
    func handleSuccess(type: RequestRepositorySuccess) {
        switch type {
        case .successRepo(let repo):
            shouldAnimate = false
            guard let items = repo.items else {
                return
            }
            repositoryModel += items
            DispatchQueue.main.async{
                self.repoTableView.reloadData()
            }
        }
        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: nil)
    }
}
