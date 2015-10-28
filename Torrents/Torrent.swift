//
//  Torrent.swift
//  Torrents
//
//  Created by Robert Dougan on 28/10/15.
//  Copyright © 2015 Robert Dougan. All rights reserved.
//

import UIKit

enum TorrentQuality: String {
    case Regular = "Regular"
    case HD = "720"
    case FullHD = "1080"
}

class Torrent: NSObject {
    
    var title: String?
    var originalTitle: String?
    
    var quality: TorrentQuality = .Regular
    
    var link: NSURL?
    
    var category: String?
    
    var date = NSDate()
    
    var seeds: Int = 0
    var leechs: Int = 0
    
    var size: Int64 = 0
    
    var downloaded: Bool = false
    
    required init(dictionary: [String: AnyObject]) {
        super.init()
        
        self.originalTitle = dictionary["title"] as? String
        self.title = self.cleanTitle(self.originalTitle)
        
        self.category = dictionary["category"] as? String
        
        if let link = dictionary["torrentLink"] as? String {
            self.link = NSURL(string: link)!
        }
        
        if let seeds = dictionary["seeds"] as? Int {
            self.seeds = seeds
        }
        
        if let leechs = dictionary["leechs"] as? Int {
            self.leechs = leechs
        }
        
        if let size = dictionary["size"] as? Int {
            self.size = Int64(size)
        }
        
        if let date = dictionary["pubDate"] as? String {
            let formatter = NSDateFormatter()
            
            // Tuesday 20 Oct 2015 03:28:12 +0000
            formatter.dateFormat = "EEEE d MMM yyyy HH:mm:ss ZZZ"
            
            if let date = formatter.dateFromString(date) {
                self.date = date
            }
        }
    }
    
    func cleanTitle(title: String?) -> String? {
        if (title == nil) {
            return nil
        }
        
        var clean = title!
        
        let weird = [
            "FLEET",
            "KILLERS",
            "INTERNAL",
            "BATV",
            "FUM",
            "2HD",
            "x264",
            "YIFY",
            "EXCELLENCE",
            "NTb",
            "LOL",
            "RMTEAM",
            "PROPER",
            "DD5\\ 1",
            "BS",
            "BrRip",
            "HEVC",
            "x265",
            "HDTV",
            "Xvid",
            "Webrip",
            "WEB\\-DL",
            "h\\ 264",
            "h\\.264",
            "dd5\\.1",
            "ehhhh",
            "mkv",
            "dvdrip",
            "ASAP",
            "define",
            "immerse",
            "ozlem",
            "e-subs",
            "fastsub",
            "vostfr",
            "addiction",
            "avi",
            "dts",
            "mrsk",
            "amc.com",
            "minutemen",
            "\\.cbr",
            "nem",
            "mux",
            "10bit",
            "mp4",
            "dimension",
            "orenji",
            "yestv",
            "lve",
            "momentum",
            "gtv",
            "tvrip",
            "h264",
            "real",
            "rudy",
            "evo",
            "aac\\ 5\\.1\\ joy",
            "ac3",
            "\\(\\ \\)",
            "bluray",
            "aac",
            "rarbg"
        ]
        
        if (clean.matches("720p|720")) {
            clean = clean.stringByReplacingOccurrencesOfRegex("720p|720", withString: "")
            self.quality = .HD
        }
        else if (clean.matches("1080p|1080")) {
            clean = clean.stringByReplacingOccurrencesOfRegex("1080p|1080", withString: "")
            self.quality = .FullHD
        }
        
        clean = clean.stringByReplacingOccurrencesOfRegex("\\[[a-zA-Z0-9,\\.\\-\\s]+\\]", withString: "")
        clean = clean.stringByReplacingOccurrencesOfRegex("(?i)" + weird.joinWithSeparator("|"), withString: "")
        clean = clean.stringByReplacingOccurrencesOfRegex("[-\\s]+", withString: " ")
        clean = clean.stringByReplacingOccurrencesOfRegex("[\\s]+", withString: " ")
        clean = clean.stringByReplacingOccurrencesOfRegex("\\|\\s\\|", withString: " ")
        clean = clean.stringByReplacingOccurrencesOfRegex("\\([\\s]*\\)", withString: " ")
        clean = clean.trim()
        
        return clean
    }
    
}
