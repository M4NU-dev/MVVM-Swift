//
//  ArticlesServices.swift
//  MVVM-Swift
//
//  Created by Luis Larrea on 7/31/21.
//

import Foundation
import RxSwift


class ArticlesServices {
    let api = BaseAPI()
    
    func listTempArticles() {
        
    }
    
    func deleteArticle() {
        
    }
    
    func listArticles() -> Observable<ObjectHits> {
        return Observable.create { observer in
            self.api.request(urlService: Constants.SERVICES.LIST_ARTICLES) { (_ hits: ObjectHits?) in
                observer.onNext(hits!)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
