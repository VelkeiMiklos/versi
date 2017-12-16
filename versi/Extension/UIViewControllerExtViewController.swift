//
//  UIViewControllerExtViewController.swift
//  versi
//
//  Created by Velkei Miklós on 2017. 12. 16..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import SafariServices
extension UIViewController{
    func presentSafariVC(url: String){
        //url + readme kiegészítés
        guard let url = URL(string: url + CO_README_SEGMENT) else {
            return
        }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
}
