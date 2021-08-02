//
//  DetailArticleRouter.swift
//  MVVM-Swift
//
//  Created by Luis Larrea on 8/1/21.
//

import Foundation
import UIKit

class DetailArticleRouter {
    private var sourceView : UIViewController?
    var urlArticle         : String?
    
    var viewController: UIViewController {
        return getHomeView()
    }
    
    init(url: String? = "") {
        self.urlArticle = url
    }
    
    private func getHomeView() -> UIViewController {
        let view = DetailArticleView(nibName: "DetailArticleView", bundle: Bundle.main)
        view.urlArticle = self.urlArticle
        return view
    }
    
    func setView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("==== SE PRODUJO UN ERROR ====") }
        self.sourceView = view
    }

}
