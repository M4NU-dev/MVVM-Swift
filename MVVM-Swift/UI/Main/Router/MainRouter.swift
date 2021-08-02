//
//  MainRouter.swift
//  MVVM-Swift
//
//  Created by Luis Larrea on 7/30/21.
//

import UIKit
import Foundation

class MainRouter {
    private var sourceView: UIViewController?
    
    var viewController: UIViewController {
        return getHomeView()
    }
    
    private func getHomeView() -> UIViewController {
        let view = MainView(nibName: "MainView", bundle: Bundle.main)
        return view
    }
    
    func setView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("==== SE PRODUJO UN ERROR ====") }        
        self.sourceView = view
    }
    
    func navDetailView(url: String) {
        let detailArticle = DetailArticleRouter(url: url).viewController
        sourceView?.navigationController?.pushViewController(detailArticle, animated: true)
    }
}
