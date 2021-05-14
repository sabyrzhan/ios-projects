//
//  TableViewController.swift
//  AmazonProductPage
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import UIKit

class TableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    static let CURRENCY_FORMATTER: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        return formatter
    }()
    
    var productDetails: ProductDetails?
    let sections:[TableSection] = [.description, .price, .relatedProducts]

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewParent: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let description = "👑[Ultra thin & light]: thin as paper, only 0.03 inches, 0.63 oz. One of the ultra-thin and super lightweight cases on the market, keep your new phone slimmer and add zero weight. While providing basic protection for your phone from scratches and stains."
        let images = ["001","002","003","004","005"]
        let relatedProducts = [
            ProductDetails(description: "New iPhone 12 Mini", images: ["related_1"], price: 699, relatedProducts: []),
            ProductDetails(description: "ESR Tempered Glass Screen Protector Compatible with iPhone 12 Mini, Display Film, Pack of 3, Practical Mounting Frame", images: ["related_2"], price: 7.49, relatedProducts: []),
            ProductDetails(description: "Choetech magnetic wireless charger, 20 W PD USB C charger with mag-safe charger, fast charging induction charging station", images: ["related_3"], price: 25.99, relatedProducts: []),
            ProductDetails(description: "UTECTION Mobile Phone Case for iPhone 12 Mini (5.4 Inches) – No Yellowing Transparent Case – Ultra Clear Flex Case Transparent ", images: ["related_4"], price: 8.99, relatedProducts: [])
        ]
        productDetails = ProductDetails(description: description, images: images, price: 12.74, relatedProducts: relatedProducts)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .description:
            return 1
        case .price:
            return 1
        case .relatedProducts:
            return productDetails!.relatedProducts.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
            case .relatedProducts:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RelatedProductTableCell", for: indexPath) as! RelatedProductTableCell
                let relatedProduct = productDetails!.relatedProducts[indexPath.row]
                cell.relatedProductImage.image = UIImage(named: relatedProduct.images[0])
                cell.relatedProductTitle.text = relatedProduct.description
                return cell
            case .description:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.text = productDetails?.description
                cell.textLabel?.numberOfLines = 0
                return cell
            case .price:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                let price = NSNumber(value: productDetails!.price)
                let priceString = Self.CURRENCY_FORMATTER.string(from: price)!
                cell.textLabel?.text = "Price: \(priceString)"
                return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        if (section == .relatedProducts) {
            return "Related products"
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetails!.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.uiImageView.image = UIImage(named: productDetails!.images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        switch section {
        case .description:
            return UITableView.automaticDimension
        case .price:
            return UITableView.automaticDimension
        case .relatedProducts:
            return 78
        }
    }
}

enum TableSection {
    case description
    case price
    case relatedProducts
}
