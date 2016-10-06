//
//  UserDefaults.swift
//  Dust
//
//  Created by Khoa Pham on 24/08/16.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import Foundation

public struct UserDefaults {

  struct Key {
    static let playerID: String = "Dust-OneSignal-Player-ID-Key"
    static let deviceToken: String = "Dust-OneSignal-Device-Token-Key"
    static let subscribed: String = "Dust-OneSignal-Disable-Subscribed-Key"
  }

  public static var playerID: String? {
    get {
      return NSUserDefaults.standardUserDefaults().stringForKey(Key.playerID)
    }

    set {
      NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: Key.playerID)
      NSUserDefaults.standardUserDefaults().synchronize()
    }
  }

  public static var deviceToken: String? {
    get {
      return NSUserDefaults.standardUserDefaults().stringForKey(Key.deviceToken)
    }

    set {
      NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: Key.deviceToken)
      NSUserDefaults.standardUserDefaults().synchronize()
    }
  }

  public static var subscribed: Bool {
    get {
      return NSUserDefaults.standardUserDefaults().boolForKey(Key.subscribed)
    }

    set {
      NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: Key.subscribed)
      NSUserDefaults.standardUserDefaults().synchronize()
    }
  }
}