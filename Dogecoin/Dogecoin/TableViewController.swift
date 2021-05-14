//
//  TableViewController.swift
//  Dogecoin
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import UIKit

class TableViewController: UITableViewController {
    static let apiCaller: APICaller = APICaller.shared
    
    @IBOutlet weak var coinLogo: UIImageView!
    @IBOutlet weak var price: UILabel!
    
    static let CURRENCY_FORMATTER: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    var tableModels:[DataCellModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getDogecoin()
    }
    @IBAction func refreshPressed(_ sender: Any) {
        tableModels.removeAll()
        tableView.reloadData()
        getDogecoin()
    }
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.coinLogo.image = image
                    }
                }
            }
        }
    }
    
    func getDogecoin() {
        Self.apiCaller.getDogecoin { result in
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    if let imageUrlStr = data.image["large"],
                       let imageUrl = URL(string: imageUrlStr) {
                        self.load(url: imageUrl)
                    }
                    
                    let currency = NSNumber(value: data.market_data.current_price["usd"]!)
                    let currString = Self.CURRENCY_FORMATTER.string(from: currency)
                    
                    let genesisDate = self.formatCreateDate(string: data.genesis_date)
                    let updateDate = self.formatUpdatedDate(string: data.last_updated)
                    
                    self.tableModels = [
                        DataCellModel(name: "ID", value: data.id),
                        DataCellModel(name: "Name", value: data.name),
                        DataCellModel(name: "Create date", value: genesisDate),
                        DataCellModel(name: "Update date", value: updateDate)
                    ]
                    DispatchQueue.main.async {
                        self.navigationItem.title = data.symbol.uppercased()
                        self.price.text = currString
                        self.tableView.reloadData()
                    }
            }
            
        }
    }
    
    func formatCreateDate(string: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        if let date = formatter.date(from: string) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            
            return dateFormatter.string(from: date)
        }
        
        return "--"
    }
    
    func formatUpdatedDate(string: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withFullTime, .withFractionalSeconds]
        if let date = formatter.date(from: string) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, HH:mm"
            
            return dateFormatter.string(from: date)
        }
        
        return "--"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell") as! DataCell
        cell.cellModel = tableModels[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return tableView.deselectRow(at: indexPath, animated: true)
    }
}
