//
//  TableViewController.swift
//  NewsApp
//
//  Created by Sabyrzhan Tynybayev on 15.05.2021.
//

import UIKit
import SafariServices
import Alamofire
import AlamofireImage

class TableViewController: UITableViewController, UISearchBarDelegate {
    let apiCaller = APICaller.shared
    var news: [NewsModel] = []
    let cache = AutoPurgingImageCache()
    
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        super.tableView.rowHeight = 100
        self.navigationItem.hidesSearchBarWhenScrolling = false
        getTopStories()
        
    }
    
    func getTopStories() {
        news.removeAll()
        tableView.reloadData()
        apiCaller.getTopStories { result in
            self.handleQueryResult(result: result)
        }
    }
    
    func handleQueryResult(result: Result<[NewsModel], Error>) {
        switch (result) {
            case .success(let news):
                self.news = news
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
        }
    }

    @IBAction func refreshPressed(_ sender: Any) {
        getTopStories()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.cache = self.cache
        cell.updateWithNews(news: self.news[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let news = self.news[indexPath.row]
        guard let url = URL(string: news.url ?? "") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            return
        }
        
        news.removeAll()
        tableView.reloadData()
        self.searchBar.endEditing(true)
        if query.isEmpty {
            getTopStories()
        } else {
            apiCaller.searchTopStories(query: query) { result in
                self.handleQueryResult(result: result)
            }
        }
    }
}
