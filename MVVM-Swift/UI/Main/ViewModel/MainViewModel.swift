//
//  MainViewModel.swift
//  MVVM-Swift
//
//  Created by Luis Larrea on 7/30/21.
//

import Foundation
import RxSwift

class MainViewModel {
    private weak var view : MainView?
    private var router    : MainRouter?
    let mData             = SharedMemory()
    
    // ================ SERVICES ================ //
    private var APIArticles = ArticlesServices()
    // ========================================== //
    
    func bind(view: MainView, rooter: MainRouter) {
        self.view   = view
        self.router = rooter
        
        self.router?.setView(view)
    }
    
    func getListArticles() -> Observable<ObjectHits> {
        return APIArticles.listArticles()
    }
    
    func makeDetailArticle(url: String) {
        router?.navDetailView(url: url)
    }
    
    func deleteArticle(article: ObjectArticle) {
        mData.getData(key: Constants.STRING_KEYS.DELETE_DATA, value_default: "") { (json) in
            do {
                
                if json == "" {
                    var hits = ObjectHits()
                    
                    hits.articulos?.append(article)
                    
                    do {
                        let jsonEncoder = JSONEncoder()
                        let jsonData = try jsonEncoder.encode(hits)
                        let json = String(data: jsonData, encoding: String.Encoding.utf8)
                                      
                        self.mData.setData(data: json, key: Constants.STRING_KEYS.DELETE_DATA)
                    } catch {
                        print("JSONSerialization error:", error)
                    }
                }else {
                    let jsonDecoder = JSONDecoder()
                    var hits = try jsonDecoder.decode(ObjectHits.self, from: json.data(using: .utf8)!)
                                                    
                    hits.articulos?.append(article)
                    
                    do {
                        let jsonEncoder = JSONEncoder()
                        let jsonData = try jsonEncoder.encode(hits)
                        let json = String(data: jsonData, encoding: String.Encoding.utf8)
                                      
                        self.mData.setData(data: json, key: Constants.STRING_KEYS.DELETE_DATA)
                    } catch {
                        print("JSONSerialization error:", error)
                    }
                }
                
            } catch {
                print("JSONSerialization error:", error)
            }
        }
    }
}
