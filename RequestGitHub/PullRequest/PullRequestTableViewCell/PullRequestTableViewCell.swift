//
//  PullRequestTableViewCell.swift
//  RequestGitHub
//
//  Created by Henrique Silva on 04/02/20.
//  Copyright © 2020 Henrique Silva. All rights reserved.
//

import UIKit

class PullRequestTableViewCell: UITableViewCell {

        @IBOutlet weak var prTitleLabel: UILabel!
        @IBOutlet weak var descriptionLabel: UILabel!
        @IBOutlet weak var ownerUsername: UILabel!
        @IBOutlet weak var profileImgView: UIImageView!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
        public func setupWith(pr: [PullRequestModel]?, index: Int, showAnimate: Bool) {
            if showAnimate {
                showSkeletonViews(show: showAnimate)
            } else {
                showSkeletonViews(show: showAnimate)
                prTitleLabel.text = pr?[index].title ?? ""
                descriptionLabel.text = pr?[index].body  ?? ""
                ownerUsername.text = pr?[index].user?.login  ?? ""
                profileImgView.sd_setImage(with: URL(string: pr?[index].user?.avatar_url ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
                
                prTitleLabel.accessibilityLabel = "Título do pull request " + (pr?[index].title ?? "")
                descriptionLabel.accessibilityLabel = "Descrição do pull request " + (pr?[index].body ?? "")
                ownerUsername.accessibilityLabel = "Usuário responsável pelo pull request  " + (pr?[index].user?.login ?? "")
            }
        }
        
        
        private func showSkeletonViews(show: Bool) {
            if show {
                prTitleLabel.isSkeletonable = show
                prTitleLabel.showAnimatedGradientSkeleton()
                descriptionLabel.isSkeletonable = show
                descriptionLabel.showAnimatedGradientSkeleton()
                ownerUsername.isSkeletonable = show
                ownerUsername.showAnimatedGradientSkeleton()
                profileImgView.isSkeletonable = show
                profileImgView.showAnimatedGradientSkeleton()
            } else {
                prTitleLabel.hideSkeleton()
                descriptionLabel.hideSkeleton()
                ownerUsername.hideSkeleton()
                profileImgView.hideSkeleton()
            }
            
        }
        
        
        
    }
