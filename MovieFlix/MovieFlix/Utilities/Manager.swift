//
//  Manager.swift
//  Bonauf
//
//  Created by cis on 4/4/18.
//  Copyright © 2018 cis. All rights reserved.
//

import UIKit
import SystemConfiguration
import AVFoundation
import Foundation

enum TableCell:String {
    case NowPlayingCell = "NowPlayingTableCell"
    case TopRatedCell = "TopRatedTableCell"
}

class Manager: NSObject {
  
    static let shared = Manager()
    private override init() { }
    
    func showAlert(_ vc:UIViewController, message: String = Constant.ALERT_TEXT) {
        let alert = UIAlertController(title: Constant.ALERT_TITLE, message:message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
 
    func getTrimmedString (_ str:String?) -> String? {
       return str?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func isNetworkConnected(_ vc:UIViewController) -> Bool {
        if self.isNetworkConnected() {
            return true
        }
        else {
            self.showAlert(vc, message: Constant.ALERT_NO_INTERNET)
            return false
        }
    }
    
    private func isNetworkConnected() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
}


public struct Constant
{
    static let API_KEY = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    static let Page_Number = "&language=en-US&page="
    static let ALERT_TITLE = "Message"
    static let ALERT_TEXT = "Oops! Something went wrong!\nPlease try again."
    static let ALERT_NO_INTERNET = "Internet connection not found, Please make sure that you are connected with internet."
    static let APP_ID = "&appid="
    static let WetherKey = "66c3fd0cb6de2383542585703136321a"
    
    static let GetDetail = "GetArrayDetail"
    static let YelloW_Color = UIColor.init(red: 205/255, green: 152/255, blue: 50/255, alpha: 1.0)
}


extension String {
    func setPercentage() -> String {
        return self + " %"
    }
}

