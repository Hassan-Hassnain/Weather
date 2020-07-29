//
//  Extensions.swift
//  Weather
//
//  Created by اسرارالحق  on 29/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import UIKit


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
