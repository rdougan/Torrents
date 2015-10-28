//
//  TorrentsViewController.swift
//  Torrents
//
//  Created by Robert Dougan on 28/10/15.
//  Copyright © 2015 Robert Dougan. All rights reserved.
//

import UIKit

import Alamofire

class TorrentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    private var results = [Torrent]()
    
    private var showEmpty = false {
        didSet {
            self.tableView.separatorStyle = showEmpty ? .None : .SingleLine
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.separatorStyle = .None
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 56
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.searchBar.becomeFirstResponder()
//        self.search("")
    }
    
    private func search(query: String) {
        let url = "https://kat.cr/json.php"
//        let url = "http://rob.local/Personal/Torrents/example.json"
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Alamofire.request(.GET, url, parameters: ["q": query])
            .responseJSON { response in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                if let JSON = response.result.value {
                    if let results = JSON.valueForKey("list") as? [[String: AnyObject]] {
                        self.results.removeAll()
                        
                        for result in results {
                            self.results.append(Torrent(dictionary: result))
                        }
                        
                        self.showEmpty = results.count == 0
                        
                        self.tableView.reloadData()
                    }
                }
        }
    }
    
    // MARK: UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.results.count
        
        if (count == 0 && self.showEmpty) {
            return 1
        }
        
        return count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (self.results.count == 0 && self.showEmpty) {
            let cell = tableView.dequeueReusableCellWithIdentifier("EmptyCell", forIndexPath: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TorrentTableViewCell
        
        let record = self.results[indexPath.row]
        cell.configure(torrent: record)

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let record = self.results[indexPath.row]
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! TorrentTableViewCell
        
        if let link = record.link {
            record.downloaded = true
            cell.configure(torrent: record)
            
            PutIO.addTorrent(link) { success in
                if (!success) {
                    record.downloaded = false
                    cell.configure(torrent: record)
                }
            }
        }
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let record = self.results[indexPath.row]
        return !record.downloaded
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let record = self.results[indexPath.row]
        if (record.downloaded) {
            return nil
        }
        
        return indexPath
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let query = searchBar.text
        if (query != nil && query != "") {
            self.search(query!)
        }
        
        self.searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText == "") {
            self.results = [Torrent]()
            self.showEmpty = false
            
            self.tableView.separatorStyle = .None
            
            self.tableView.reloadData()
        }
    }

}
