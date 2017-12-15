//
//  SearchCell.swift
//  versi
//
//  Created by Velkei Miklós on 2017. 12. 14..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var repoDescriptionLbl: UILabel!
    @IBOutlet weak var forksCountLbl: UILabel!
    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!

    public private(set) var repoUrl: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(repo: Repo){
        repoNameLbl.text = repo.repoName
        repoDescriptionLbl.text = repo.repoDesc
        forksCountLbl.text = String(describing: repo.numberofForks)
        languageLbl.text = repo.language
        repoUrl = repo.repoUrl
    }
}
