//
//  CustomButton.swift
//  versi
//
//  Created by Velkei Miklós on 2017. 12. 15..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        self.layer.borderWidth = 3
        self.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.layer.cornerRadius = self.frame.height / 2
    }

}
