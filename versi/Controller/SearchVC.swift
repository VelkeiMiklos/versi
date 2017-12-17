//
//  SearchVC.swift
//  versi
//
//  Created by Velkei Miklós on 2017. 12. 14..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchVC: UIViewController, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var searchText: CustomTextField!
    @IBOutlet weak var tableView: UITableView!
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindSearchElement()
        tableView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
    func bindSearchElement(){
        let searchResultsObservable = searchText.rx.text
            .orEmpty//string? convert to string
            .debounce(0.5, scheduler: MainScheduler.instance)// fél másodperce beállítja
            .map{//for mindenen
                $0.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""//átkonvetrálni url kompatibilissé
            }//searchquery konvertálása observable repo array típusra
            .flatMap { (query) -> Observable<[Repo]> in
                if query == ""{
                    return Observable<[Repo]>.just([])//létrehoz egy üres elemet
                }else{// ha van keresni való
                    //URl összekonkatenálása
                    var searchRepo = [Repo]()
                    let url = CO_SEARCH_URL + query + CO_STARS_DESCENDING_SEGMENT
                    return URLSession.shared.rx.json(url: URL(string: url)!).map{
                        let result = $0 as AnyObject
                        let items = result.object(forKey: CO_ITEMS) as? [Dictionary<String,Any>] ?? []
                        
                        for item in items{
                            guard let name = item[CO_NAME] as? String,
                                let description = item[CO_DESCRIPTION] as? String,
                                let language = item[CO_LANGUAGE] as? String,
                                let forksCount = item[CO_FORKS_COUNT] as? Int,
                                let repoUrl = item[CO_REPO_URL] as? String else{
                                    break
                            }
                              let repo = Repo(repoName: name, repoDesc: description, repoImage: #imageLiteral(resourceName: "searchIconLarge"), numberofForks: forksCount, constributors: 0, language: language, repoUrl: repoUrl)
                            searchRepo.append(repo)
                        }
                        return searchRepo
                    }
                }
        }
            .observeOn(MainScheduler.instance)
        searchResultsObservable.bind(to: tableView.rx.items(cellIdentifier: "searchCell")){(row, repo:Repo, cell: SearchCell) in
            cell.configureCell(repo: repo)
        }
            .addDisposableTo(disposeBag)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchCell else {
            return
        }
        let url = cell.repoUrl!
        self.presentSafariVC(url: url)
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
