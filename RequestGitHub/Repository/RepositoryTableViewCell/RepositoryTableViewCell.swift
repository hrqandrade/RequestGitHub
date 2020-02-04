//
//  RepositoryTableViewCell.swift
//  RequestGitHub
//
//  Created by Henrique Silva on 03/02/20.
//  Copyright © 2020 Henrique Silva. All rights reserved.
//

import UIKit
import SDWebImage
import SkeletonView

class RepositoryTableViewCell: UITableViewCell{
    
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var ownerUsername: UILabel!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setupWith(repo: [Item]?, index: Int, showAnimate: Bool) {
        if showAnimate {
            showSkeletonViews(show: showAnimate)
        } else {
            showSkeletonViews(show: showAnimate)
            repositoryNameLabel.text = repo?[index].name
            descriptionLabel.text = repo?[index].description
            forkLabel.text = formatNumber(repo?[index].forks ?? 0)
            starLabel.text = formatNumber(repo?[index].stargazersCount ?? 0)
            ownerUsername.text = repo?[index].owner?.login
            fullname.text = repo?[index].fullName
            profileImgView.sd_setImage(with: URL(string: repo?[index].owner?.avatarURL ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            
            repositoryNameLabel.accessibilityLabel = "Nome do repositório " + (repo?[index].name ?? "")
            descriptionLabel.accessibilityLabel = "Descrição do repositório " + (repo?[index].description ?? "")
            forkLabel.accessibilityLabel = "Número de Forks "  +  formatNumberAcessibility(repo?[index].forks ?? 0)
            starLabel.accessibilityLabel = "Número de Estrelas " + formatNumberAcessibility(repo?[index].stargazersCount ?? 0)
            ownerUsername.accessibilityLabel = "Usuário dono do repositório  " + (repo?[index].owner?.login ?? "")
        }
    }
    
    
    private func showSkeletonViews(show: Bool) {
        if show {
            repositoryNameLabel.isSkeletonable = show
            repositoryNameLabel.showAnimatedGradientSkeleton()
            descriptionLabel.isSkeletonable = show
            descriptionLabel.showAnimatedGradientSkeleton()
            forkLabel.isSkeletonable = show
            forkLabel.showAnimatedGradientSkeleton()
            starLabel.isSkeletonable = show
            starLabel.showAnimatedGradientSkeleton()
            ownerUsername.isSkeletonable = show
            ownerUsername.showAnimatedGradientSkeleton()
            fullname.isSkeletonable = show
            fullname.showAnimatedGradientSkeleton()
            profileImgView.isSkeletonable = show
            profileImgView.showAnimatedGradientSkeleton()
        } else {
            repositoryNameLabel.hideSkeleton()
            descriptionLabel.hideSkeleton()
            forkLabel.hideSkeleton()
            starLabel.hideSkeleton()
            ownerUsername.hideSkeleton()
            fullname.hideSkeleton()
            profileImgView.hideSkeleton()
        }
        
    }
    
    
    
}
