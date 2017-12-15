//
//  Model.swift
//  versi
//
//  Created by Velkei Miklós on 2017. 12. 15..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
class Repo{
    public private(set) var repoName: String
    public private(set) var repoDesc: String
    public private(set) var repoImage: UIImage
    public private(set) var numberofForks: Int
    public private(set) var constributors: Int
    public private(set) var language: String
    public private(set) var repoUrl: String
    
    init(repoName: String, repoDesc: String, repoImage: UIImage, numberofForks: Int, constributors: Int, language: String, repoUrl: String) {
        self.repoName = repoName
        self.repoDesc = repoDesc
        self.repoImage = repoImage
        self.numberofForks = numberofForks
        self.constributors = constributors
        self.language = language
        self.repoUrl = repoUrl
    }
    
    
}
