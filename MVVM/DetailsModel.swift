//
//  DetailsModel.swift
//  CollectionWithTableView
//
//  Created by shalini on 02/10/22.
//

import Foundation
struct DetailsModel{
    var total_pages:Int=0
    var total:Int=0
    var perPage:Int=0
    var details = [UserDetails]()
    init(json:[String:Any]){
        self.perPage = json["per_page"] as? Int ?? 0
        if let user = json["data"] as? [[String:Any]]{
            self.details = user.map({UserDetails(data: $0)})
    }
    }
}
struct UserDetails{
    let id : Int
    let emailid : String
    let firstname : String
    let lastname : String
    var avatar : String
    init(data:[String:Any]){
        id = data["id"] as? Int ?? 0
        emailid = data["email"] as? String ?? ""
        firstname = data["first_name"] as? String ?? ""
        lastname = data["last_name"] as? String ?? ""
        avatar = data["avatar"] as? String ?? ""
 }

    
}
