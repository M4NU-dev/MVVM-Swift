//
//  SharedMemory.swift
//  femmebrows
//
//  Created by Luis Larrea on 2/3/19.
//  Copyright © 2019 GlobalSoft. All rights reserved.
//

import Foundation

class SharedMemory{
    let mPreferences  = UserDefaults.standard
    
    public func setData<V>(data: V, key: String){
        mPreferences.set(data, forKey: key)
    }
    
    public func getData<V>(key: String, value_default: V, completion: @escaping(V) -> ()){
        if let value = mPreferences.object(forKey: key) as! V?{
            completion(value)
        }else{
            completion(value_default)
        }
    }
}
