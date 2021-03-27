//
//  RefreshScrollView.swift
//  CurRates
//
//  Created by Maksim Kalik on 3/26/21.
//

import UIKit
import SwiftUI

struct RefreshScrollView<RootView>: UIViewRepresentable where RootView: View {
    var width: CGFloat
    var height: CGFloat
    var handlePullToRefresh: () -> Void
    let rootView: () -> RootView
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(context.coordinator, action: #selector(Coordinator.handleRefreshControl), for: .valueChanged)
        
        let refreshVC = UIHostingController(rootView: rootView() )
        refreshVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        scrollView.addSubview(refreshVC.view)
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {}
    
    func makeCoordinator() -> Coordinator<RootView> {
        Coordinator(self, rootView: rootView, handlePullToRefresh: handlePullToRefresh)
    }
    
    class Coordinator<RootView>: NSObject where RootView: View {
        var refreshScrollView: RefreshScrollView
        var handlePullToRefresh: () -> Void
        var rootView: () -> RootView
        
        init(_ refreshScrollView: RefreshScrollView, rootView: @escaping () -> RootView, handlePullToRefresh: @escaping () -> Void) {
            self.refreshScrollView = refreshScrollView
            self.handlePullToRefresh = handlePullToRefresh
            self.rootView = rootView
        }
        
        @objc func handleRefreshControl(sender: UIRefreshControl) {
            sender.endRefreshing()
            handlePullToRefresh()
        }
    }
}
