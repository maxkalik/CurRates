//
//  ViewControllerResolver.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/26/21.
//

import SwiftUI

typealias OnResolveType = (UIViewController) -> Void

final class ViewControllerResolver: UIViewControllerRepresentable {
    
    let onResolve: OnResolveType
    
    init(onResolve: @escaping OnResolveType) {
        self.onResolve = onResolve
    }
    
    func makeUIViewController(context: Context) -> ParentResolverViewController {
        ParentResolverViewController(onResolve: onResolve)
    }
    
    func updateUIViewController(_ uiViewController: ParentResolverViewController, context: Context) { }
}

class ParentResolverViewController: UIViewController {
    let onResolve: OnResolveType
    
    init(onResolve: @escaping OnResolveType) {
        self.onResolve = onResolve
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(onResolve:) to instantiate ParentResolverViewController.")
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if let parent = parent {
            onResolve(parent)
        }
    }
}
