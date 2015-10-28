//
//  TorrentTableViewCell.swift
//  Torrents
//
//  Created by Robert Dougan on 28/10/15.
//  Copyright © 2015 Robert Dougan. All rights reserved.
//

import UIKit

import NSDate_TimeAgo

class TorrentTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var seedsLabel: UILabel!
    @IBOutlet var leechsLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var qualityLabel: UILabel!
    
    @IBOutlet var rightViewHeightConstraint: NSLayoutConstraint!
    
    private var title: String?
    private var originalTitle: String?
    
    var hasToggledTitle = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(torrent torrent: Torrent) {
        self.nameLabel.text = torrent.title
        
        self.dateLabel.text = self.getShortRelativeDateFor(torrent.date)
        self.seedsLabel.text = "\(torrent.seeds) SEEDS"
        self.leechsLabel.text = "\(torrent.leechs) LEECHES"
        self.sizeLabel.text = "  " + NSByteCountFormatter().stringFromByteCount(torrent.size) + "  "
        
        self.title = torrent.title
        self.originalTitle = torrent.originalTitle
        
        self.rightViewHeightConstraint.constant = torrent.quality == .Regular ? 16 : 39
        
        if (torrent.quality != .Regular) {
            self.qualityLabel.text = torrent.quality == .HD ? "720" : "1080"
        }
        
        if (torrent.downloaded) {
            self.contentView.alpha = 0.3
        }
    }
    
    func getShortRelativeDateFor(date: NSDate) ->String {
        let timeInterval = -date.timeIntervalSinceNow
        
        switch timeInterval {
        case 0..<60:
            return String(format: "%.f S", timeInterval)
        case 60..<(60 * 60):
            return String(format: "%.f M", timeInterval / 60)
        case (60 * 60)..<(60 * 60 * 24):
            return String(format: "%.f HR", timeInterval / (60 * 60))
        case (60 * 60 * 24)..<(60 * 60 * 24 * 365):
            return String(format: "%.f D", timeInterval / (60 * 60 * 24))
        default:
            return String(format: "%.f Y", timeInterval / (60 * 60 * 24 * 365))
        }
    }
    
    private func toggleTitle() {
        self.nameLabel.text = (self.nameLabel.text == self.title) ? self.originalTitle : self.title
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            if (touch.force > 4 && !self.hasToggledTitle) {
                self.toggleTitle()
                self.hasToggledTitle = true
            }
        }
        
        super.touchesMoved(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.hasToggledTitle = false
        
        super.touchesEnded(touches, withEvent: event)
    }

}
