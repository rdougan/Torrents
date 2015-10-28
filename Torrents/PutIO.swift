//
//  PutIO.swift
//  Torrents
//
//  Created by Robert Dougan on 28/10/15.
//  Copyright © 2015 Robert Dougan. All rights reserved.
//

import Foundation

import Alamofire

let kPutIOUserToken = "xxxxx"

class PutIO {
    
    class var accessToken: String? {
        return kPutIOUserToken
    }
    
    class func addTorrent(url: NSURL, callback: ((success: Bool) -> Void)) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Alamofire.request(.POST, "https://api.put.io/v2/transfers/add", parameters: ["url": url, "oauth_token": PutIO.accessToken!])
            .responseJSON { response in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                if let _ = response.result.value {
                    callback(success: true)
                }
                else {
                    callback(success: false)
                }
        }
    }
    
}