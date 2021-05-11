//
//  UIViewController+Extention.swift
//  TrycariOS
//
//  Created by Musthafa on 11/05/21.
//

import UIKit

extension UIViewController {
    func hideNavigationBar(animated: Bool){
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    func showNavigationBar(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}
