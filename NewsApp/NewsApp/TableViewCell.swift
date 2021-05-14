//
//  TableViewCell.swift
//  NewsApp
//
//  Created by Sabyrzhan Tynybayev on 15.05.2021.
//

import UIKit
import Alamofire
import AlamofireImage

class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    var cache: AutoPurgingImageCache?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        newsImage.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func updateWithNews(news: NewsModel) {
        titleLabel.text = news.title
        descLabel.text = news.content ?? "No content"
        guard let imageUrl = news.urlToImage else {
            return
        }
        
        let existingImage = cache?.image(withIdentifier: news.urlToImage!)
        if existingImage == nil {
            AF.request(imageUrl).responseImage { image in
                guard let uiImage = image.value else {
                    return
                }
                
                self.newsImage.image = uiImage
                self.cache?.add(uiImage, withIdentifier: news.urlToImage!)
            }
        } else {
            self.newsImage.image = cache?.image(withIdentifier: news.urlToImage!)
        }
    }
}
