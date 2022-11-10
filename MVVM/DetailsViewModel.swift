//
//  DetailsViewModel.swift
//  CollectionWithTableView
//
//  Created by shalini on 02/10/22.
//

import Foundation

class DetailsViewModel{
    private var dataModel : DetailsModel?
    
    func requestData(_ url :String, page:Int, completion:((_ success:Bool)->Void)?){
        var urlComponent = URLComponents(string: url)
        urlComponent?.queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        ApiService.shared.apiData(with: URLRequest(url: (urlComponent?.url)!) ) { [self] error, jsondata in
            if error != nil {
                completion?(false)
                
            }else{
                if let jsondata = jsondata {
                    if page == 1{
                        self.dataModel = DetailsModel(json: jsondata)
                    }else{
                        let data = DetailsModel(json: jsondata)
                        self.dataModel?.details += data.details
                    }
                    //print(self.userArray)
                    completion?(true)
                }
            }
        }
    }
    
    var pagecount:Int{
        
        return self.dataModel?.total_pages ?? 0
    }
    func getnumberofsections()->Int{
        
        return (self.dataModel?.details.count ?? 0)+1
    }
    func getUserDetails(row:Int)->UserDetails?{
        
        return self.dataModel?.details[row]
    }
    var imageArray:[String]{
        var imgArr = [String]()
        if let count = self.dataModel?.perPage{
            for index in 0..<count{
                imgArr.append(self.dataModel?.details[index].avatar ?? "https://picsum.photos/200/300 ")
            }
        }
        return imgArr
    }
    
}
