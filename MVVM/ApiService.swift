//
//  ApiService.swift
//  CollectionWithTableView
//
//  Created by shalini on 02/10/22.
//

import Foundation
class ApiService{
    static let shared = ApiService()
    private init(){
        
    }
    
    func apiData(with url :URLRequest, completion:@escaping((Error?,[String:Any]?)->Void) ){

        let task = URLSession.shared.dataTask(with: url ){ (data, response, error) in
            
            guard  let data = data, error == nil else{
                print(error?.localizedDescription ?? "error occured")
                completion(error, nil)
                return
            }
            if let  json = try? JSONSerialization.jsonObject(with: data, options:[]) as? [String: Any]{
  print(json)
                completion(nil, json)
            }
        }
        task.resume()
    }
}
