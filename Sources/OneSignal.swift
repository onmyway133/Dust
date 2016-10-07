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

  static var appID: String = ""
  static let version = "020115"
  static let baseURL = NSURL(string: "https://onesignal.com/api/v1")!

  enum NotificationType: Int {
    case subscribed = 7
    case unsubscribed = -2

    static func value() -> Int {
      return UserDefaults.subscribed
        ? NotificationType.subscribed.rawValue : NotificationType.unsubscribed.rawValue
    }
  }

  enum Provisioning: Int {
    case development = 1
  }

  public static func setup(appID appID: String) {
    NSUserDefaults.standardUserDefaults().registerDefaults([
      UserDefaults.Key.subscribed: true
    ])

    OneSignal.appID = appID
  }

  public static func registerOrUpdateSession(completion: ((String?) -> Void)? = nil) {
    guard let bundleID = NSBundle.mainBundle().bundleIdentifier,
      let deviceToken = UserDefaults.deviceToken
    else {
      return
    }

    var params: [String: AnyObject] = [
      "app_id" : appID,
      "device_model" : Utils.deviceModel(),
      "device_os" : Utils.systemVersion(),
      "language" : Utils.language(),
      "timezone" : NSNumber(integer: Utils.timezone()),
      "device_type" : NSNumber(integer : 0),
      "sounds" : Utils.soundFiles(),
      "sdk" : version,
      "identifier" : deviceToken,
      "net_type" : NSNumber(integer: Utils.netType()),
      "rooted": NSNumber(bool: false),
      "as_id": "OptedOut",
      "sdk_type": "native",
      "ios_bundle": bundleID,
      "game_version": Utils.versionNumber() ?? "",
      "notification_types": NotificationType.value(),
    ]

    #if DEBUG
      params["test_type"] = Provisioning.development.rawValue
    #endif

    let url: NSURL

    if let playerID = UserDefaults.playerID {
      url = baseURL.URLByAppendingPathComponent("players/\(playerID)/on_session")
    } else {
      url = baseURL.URLByAppendingPathComponent("players")
    }

    Alamofire
    .request(.POST, url, parameters: params)
    .responseJSON { response in
      guard let json = response.result.value as? [String: AnyObject]
      else {
        completion?(nil)
        return
      }

      if let id = json["id"] as? String {
        UserDefaults.playerID = id
        completion?(id)
      } else if let value = json["success"] as? Int,
        playerID = UserDefaults.playerID where value == 1 {
        completion?(playerID)
      } else {
        completion?(nil)
      }
    }
  }

  public static func handle(deviceToken data: NSData) {
    UserDefaults.deviceToken = Utils.parse(deviceToken: data)
    registerOrUpdateSession()
  }

  public static func update(subscription subscribed: Bool) {
    guard let playerID = UserDefaults.playerID else { return }
    UserDefaults.subscribed = subscribed

    let url = baseURL.URLByAppendingPathComponent("players/\(playerID)")
    let params: [String: AnyObject] = [
      "app_id": appID,
      "notification_types": NotificationType.value()
    ]

    Alamofire
    .request(.PUT, url, parameters: params)
    .responseJSON { response in
      print(response)
    }
  }

  public static func update(badge count: Int) {
    guard let playerID = UserDefaults.playerID else { return }

    let url = baseURL.URLByAppendingPathComponent("players/\(playerID)")
    let params: [String: AnyObject] = [
      "app_id": appID,
      "badge_count": count
    ]

    Alamofire
      .request(.PUT, url, parameters: params)
      .responseJSON { response in

    }
  }

  public static func getPlayerID(completion: String -> Void) {
    if let playerID = UserDefaults.playerID {
      completion(playerID)
      return
    }

    registerOrUpdateSession { playerID in
      if let playerID = playerID {
        completion(playerID)
      }
    }
  }
}