//
//  RepoCell.swift
//  versi
//
//  Created by Velkei Miklós on 2017. 12. 14..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {

    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var repoDescLbl: UILabel!
    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var numberOfForksLbl: UILabel!
    @IBOutlet weak var viewReadMeBtn: UIButton!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var constributorsLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private var repoUrl: String?
    
    func configureCell(repo: Repo){
        
        self.repoNameLbl.text = repo.repoName
        self.repoDescLbl.text = repo.repoDesc
        self.repoImage.image = repo.repoImage
        self.numberOfForksLbl.text = String(describing: repo.numberofForks)
        self.constributorsLbl.text = String(describing: repo.constributors)
        self.languageLbl.text = repo.language
        self.repoUrl = repo.repoUrl
    }
}
