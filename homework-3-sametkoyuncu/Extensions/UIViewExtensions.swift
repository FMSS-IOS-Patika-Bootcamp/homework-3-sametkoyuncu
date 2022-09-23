//
//  UIViewExtensions.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 23.09.2022.
//

import UIKit
// Toast Message Extension - error'lar için kullanıldı
extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: 80, width: 150, height: 40))
        toastLabel.backgroundColor = UIColor(named: "themeBlue")!
        toastLabel.textColor = UIColor.darkGray
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 20;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.5
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }    
}


