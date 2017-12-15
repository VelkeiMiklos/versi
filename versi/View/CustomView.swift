//
//  CustomView.swift
//  versi
//
//  Created by Velkei Miklós on 2017. 12. 15..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class CustomView: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.shadowColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 5.0
        self.layer.cornerRadius = 15
    }

}
