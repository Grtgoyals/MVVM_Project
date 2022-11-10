//
//  CollectionTableViewCell.swift
//  CollectionWithTableView
//
//  Created by shalini on 03/10/22.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    var imageArray:[String]!{
        didSet{
            myCollectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        self.myCollectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCollectionViewCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as? MyCollectionViewCell else{
            return UICollectionViewCell()
        }
        if let urlImage = URL(string: imageArray[indexPath.row] ){
            cell.headerImages.imageDownload(from: urlImage)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width , height:collectionView.frame.size.height)
    }
    
    
}
extension UIImageView{
    func imageDownload(from url :URL){
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            guard let httpResp = response as? HTTPURLResponse,
                  httpResp.statusCode == 200,
                  let imgType = response?.mimeType, imgType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else{
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        })
        dataTask.resume()
    }
}
