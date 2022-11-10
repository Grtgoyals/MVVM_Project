//
//  ViewController.swift
//  CollectionWithTableView
//
//  Created by shalini on 02/10/22.
//

import UIKit
import MBProgressHUD
class ViewController: UIViewController {
    lazy var detailsViewModel:DetailsViewModel={
        return DetailsViewModel()
    }()
    
    
    var currentPage :Int = 1
    var isLoadingList:Bool = false
    
    var url = "https://reqres.in/api/users"
    
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.register(UINib(nibName: "CollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionTableViewCell")
        self.tableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTableViewCell")
        MBProgressHUD.showAdded(to: self.view, animated: true)
        detailsViewModel.requestData(url, page: currentPage) { success in
            if success{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                        MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
        }
    }
    
   
    func loadMoreItemsForList(){
        currentPage += 1
        detailsViewModel.requestData(url, page: currentPage) { success in
            if success{
            DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList){
            self.isLoadingList = true
            self.loadMoreItemsForList()
            
        }
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsViewModel.getnumberofsections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell", for: indexPath) as? CollectionTableViewCell {
                cell.imageArray = detailsViewModel.imageArray
                return cell
                
            }
        }else{
            let user = detailsViewModel.getUserDetails(row: indexPath.row-1)
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? MyTableViewCell {
                cell.firstname.text = user?.firstname
                cell.lastname.text = user?.lastname
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 200
        }
        return UITableView.automaticDimension
    }
}


