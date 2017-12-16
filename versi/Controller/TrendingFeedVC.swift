//
//  ViewController.swift
//  versi
//
//  Created by Velkei Miklós on 2017. 12. 14..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TrendingFeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    let refreshControl = UIRefreshControl()
    
    var dataSource = PublishSubject<[Repo]>()//csak új itemeket tud "subscriebolni" ami előtte van azokat nem
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refreshControl
        tableView.tintColor = #colorLiteral(red: 0.2807125449, green: 0.4623855948, blue: 0.9024894238, alpha: 1)
        refreshControl.addTarget(self, action: #selector(downloadData), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Hot Github Repos ", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.2807125449, green: 0.4623855948, blue: 0.9024894238, alpha: 1),
             NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold" , size: 16)!])
        self.downloadData()
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "repoCell")) { (row, repo: Repo, cell: RepoCell) in
            cell.configureCell(repo: repo)}.addDisposableTo(disposeBag)
    }

    
    @objc func downloadData(){
        DataServices.instance.downloadTrendingDictRepository { (success, repoDictArray) in
            if success{
                DataServices.instance.convertDictArrayToRepo(repoDictArray: repoDictArray!, completion: { (returndRepoArray) in
                    self.dataSource.onNext(returndRepoArray)//hozzá adja a dataSource-hoz
                })
            }
        }
        refreshControl.endRefreshing()
    }
}


