//
//  ViewController.swift
//  versi
//
//  Created by Velkei Miklós on 2017. 12. 14..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class TrendingFeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib
    }

}
extension TrendingFeedVC: UITableViewDelegate, UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 2
        }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as? RepoCell else { return UITableViewCell() }
        let repo = Repo(repoName: "Swift", repoDesc: "Swift Description", repoImage: #imageLiteral(resourceName: "searchIconLarge"), numberofForks: 3456, constributors: 654, language: "SWIFT", repoUrl: "www.google.hu")
            cell.configureCell(repo: repo)
            return cell
        }
}
