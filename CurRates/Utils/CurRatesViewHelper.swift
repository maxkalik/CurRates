//
//  CurRatesViewHelper.swift
//  CurRates
//
//  Created by Maksim Kalik on 5/5/21.
//

import UIKit

final class CurRatesViewHelper {
    
    static let shared = CurRatesViewHelper()
    private init() {}
    
    func navigationBarAppearance() {
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.systemFont(ofSize: 22, weight: .bold),.foregroundColor: UIColor.systemGray4]
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont.systemFont(ofSize: 34, weight: .bold), .foregroundColor: UIColor.systemGray4]
    }
}
