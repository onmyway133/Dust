//
//  OneSignal.swift
//  Dust
//
//  Created by Khoa Pham on 24/08/16.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import Foundation
import Alamofire

public struct OneSignal {

  public static var appID: String = ""

  static let version = "011303"
  static let baseURL = NSURL(string: "https://onesignal.com/api/v1")!

  public static func handleBadge(count: Int) {

  }

  public static func handleDeviceToken(data: NSData) {
    UserDefaults.deviceToken = Utils.parseDeviceToken(data)
  }

  public static func registerUser(completion: ((String?) -> Void)) {
    let params: [String: AnyObject] = [
      "app_id" : appID,
      "device_model" : Utils.deviceModel(),
      "device_os" : Utils.systemVersion(),
      "language" : Utils.language(),
      "timezone" : NSNumber(integer: Utils.timezone()),
      "device_type" : NSNumber(integer : 0),
      "sounds" : Utils.soundFiles(),
      "sdk" : version,
      "identifier" : UserDefaults.deviceToken ?? "",
      "net_type" : NSNumber(integer: Utils.netType()),
      "rooted": NSNumber(bool: false),
      "as_id": "OptedOut",
      "sdk_type": "native",
      "ios_bundle": NSBundle.mainBundle().bundleIdentifier ?? "",
      "notification_types": NSNumber(integer: 0)
    ]

    let url: NSURL

    if let playerID = UserDefaults.playerID {
      url = baseURL.URLByAppendingPathComponent("players/\(playerID)/on_session")
    } else {
      url = baseURL.URLByAppendingPathComponent("players")
    }

    Alamofire
      .request(.POST, url, parameters: params)
      .responseJSON { response in
        guard let json = response.result.value as? [String: AnyObject],
          id = json["id"] as? String
          else {
            completion(nil)
            return
        }

        UserDefaults.playerID = id
        completion(id)
      }
  }
}