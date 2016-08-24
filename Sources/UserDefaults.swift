//
//  UserDefaults.swift
//  Dust
//
//  Created by Khoa Pham on 24/08/16.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import Foundation

struct UserDefaults {

  struct Key {
    static let playerID: String = "Dust-OneSignal-Player-ID-Key"
  }

  var playerID: String? {
    get {
      return NSUserDefaults.standardUserDefaults().stringForKey(Key.playerID)
    }

    set {
      NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: Key.playerID)
      NSUserDefaults.standardUserDefaults().synchronize()
    }
  }
}