//
//  DetailArticleView.swift
//  MVVM-Swift
//
//  Created by Luis Larrea on 8/1/21.
//

import UIKit
import WebKit

class DetailArticleView: UIViewController {
    @IBOutlet weak var viewUrlArticle: WKWebView!
    
    private var router    = DetailArticleRouter()
    private var viewModel = DetailArticleViewModel()
    
    var urlArticle : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bind(view: self, router: router)
        showArticleWeb(url: urlArticle!)
    }
    
    func showArticleWeb(url: String) {
        viewUrlArticle.load(URLRequest(url: URL(string: url)!))
    }
}
