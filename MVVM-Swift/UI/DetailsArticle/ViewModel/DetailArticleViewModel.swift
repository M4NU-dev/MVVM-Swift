//
//  DetailViewModel.swift
//  MVVM-Swift
//
//  Created by Luis Larrea on 8/1/21.
//

import Foundation

class DetailArticleViewModel {
    private(set) weak var view : DetailArticleView?
    private var router         : DetailArticleRouter?
    
    // ================ SERVICES ================ //
    private var APIArticles = ArticlesServices()
    // ========================================== //
    
    func bind(view: DetailArticleView, router: DetailArticleRouter) {
        self.view   = view
        self.router = router
        
        self.router?.setView(view)
    }
    
    func getArticle() -> String{
        return (self.router?.urlArticle)!
    }
}
