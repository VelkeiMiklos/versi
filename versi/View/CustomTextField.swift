//
//  CustomTextField.swift
//  versi
//
//  Created by Velkei Miklós on 2017. 12. 15..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.2807125449, green: 0.4623855948, blue: 0.9024894238, alpha: 1)])
        attributedPlaceholder = placeholder
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        self.layer.borderWidth = 3
        self.layer.borderColor = #colorLiteral(red: 0.2807125449, green: 0.4623855948, blue: 0.9024894238, alpha: 1)
        self.layer.cornerRadius = self.frame.height / 2
    }

}
