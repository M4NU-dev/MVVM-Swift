//
//  BaseAPI.swift
//  MVVM-Swift
//
//  Created by Luis Larrea on 7/31/21.
//

import Foundation
import Alamofire

class BaseAPI {
    private var urlServer: String
    private var manager: Session
    
    init() {
        self.urlServer = Constants.URL.API_DEV
        
        let configuration: URLSessionConfiguration = {
            let config = URLSessionConfiguration.default
            
            return config
        }()
        
        self.manager = Session(configuration: configuration)
    }
    
    func request<T:Codable>(urlService: String, successHandler: @escaping(T?) -> Void) {
        manager.request("\(self.urlServer)\(urlService)").validate().responseDecodable(of: T.self) { response in
            guard let data = response.value else { return }
            successHandler(data)
        }
    }
}

