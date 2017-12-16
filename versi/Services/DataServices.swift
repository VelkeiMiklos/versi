//
//  DataServices.swift
//  versi
//
//  Created by Velkei Miklós on 2017. 12. 15..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class DataServices{
    
    static let instance = DataServices()
    
    func downloadTrendingDictRepository( completion: @escaping(_ success: Bool, _ returnedRepoArray: [Dictionary<String,Any>]?)->() ){
        var trendingRepoArray = [Dictionary<String,Any>]()
        Alamofire.request(CO_TRENDING_REPO_URL).responseJSON { (response) in
            if response.error == nil{
                guard let json = response.value as? Dictionary<String,Any> else { return }
                guard let repoDictArray = json[CO_ITEMS] as? [Dictionary<String,Any>] else { return }
                
                for repoDict in repoDictArray{
                    
                    if trendingRepoArray.count < 9{
                        guard let name = repoDict[CO_NAME] as? String,
                            let forksCount = repoDict[CO_FORKS_COUNT] as? Int,
                            let description = repoDict[CO_DESCRIPTION] as? String,
                            let language  = repoDict[CO_LANGUAGE] as? String,
                            let repoUrl = repoDict[CO_REPO_URL] as? String,
                            let constributorsURL = repoDict[CO_CONTRIBUTORS_URL] as? String,
                            let ownerDict = repoDict[CO_OWNER] as? Dictionary<String, Any>,
                            let avatarUrl = ownerDict[CO_AVATAR_URL] as? String else{
                                break
                        }
                        let repoDictionary: Dictionary<String, Any> = [ CO_NAME: name,
                                                                        CO_FORKS_COUNT: forksCount,
                                                                        CO_DESCRIPTION: description,
                                                                        CO_LANGUAGE: language,
                                                                        CO_REPO_URL: repoUrl,
                                                                        CO_CONTRIBUTORS_URL: constributorsURL,
                                                                        CO_AVATAR_URL: avatarUrl]
                        trendingRepoArray.append(repoDictionary)
                        //print(repoDictionary)
                    }else{
                        break
                    }
                }
                
                completion(true, trendingRepoArray)
            }else{
                completion(false, nil)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    func convertDictArrayToRepo(repoDictArray:[Dictionary<String,Any>],  completion: @escaping (_ repo: [Repo])->()){
        var repoArray = [Repo]()
        for repoDict in repoDictArray{
            convertDictToRepo(repoDict: repoDict, completion: { (repo) in
                repoArray.append(repo)
                completion(repoArray)
            })
        }
    }
    
    func convertDictToRepo(repoDict:Dictionary<String,Any>, completion: @escaping (_ repo: Repo)->() ){
        
        let name = repoDict[CO_NAME] as! String
        let forksCount = repoDict[CO_FORKS_COUNT] as! Int
        let description = repoDict[CO_DESCRIPTION] as! String
        let language  = repoDict[CO_LANGUAGE] as! String
        let repoUrl = repoDict[CO_REPO_URL] as! String
        let constributorsURL = repoDict[CO_CONTRIBUTORS_URL] as! String
        let avatarUrl = repoDict[CO_AVATAR_URL] as! String
        
        downloadAvatarImage(avatarUrl: avatarUrl) { (success, avatarImage) in
            if success{
                let avatarImage = avatarImage
                print(constributorsURL)
                self.downloadConstributors(constributorsURL: constributorsURL, completion: { (constributorsCount) in
                    let constributorsCount = constributorsCount
                    let repo = Repo(repoName: name, repoDesc: description, repoImage: avatarImage, numberofForks: forksCount, constributors: constributorsCount, language: language, repoUrl: repoUrl)
                    completion(repo)
                })
            }
        }
    }
    
    func downloadAvatarImage(avatarUrl: String, completion: @escaping(_ success: Bool, _ image: UIImage)->()){
        
        Alamofire.request(avatarUrl).responseImage(completionHandler: { (response) in
            guard let image = response.value else { return }
            // print("image was downloaded")
            completion(true,image)
        })
    }
    
    func downloadConstributors(constributorsURL: String, completion: @escaping(_ contributors: Int)->()){
        Alamofire.request(constributorsURL).responseJSON { (response) in
            guard let json = response.value as? [Dictionary<String,Any>] else {
                return
            }
            if !json.isEmpty {
                let contributions = json.count
                print(contributions)
                completion(contributions)
            }
        }
    }
    
}
