//
//  Utils.swift
//  Dust
//
//  Created by Khoa Pham on 24/08/16.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import Foundation

struct Utils {

  static func parseDeviceToken(data: NSData) -> String {
    let buffer = UnsafePointer<CChar>(data.bytes)
    var string = ""

    for i in 0..<data.length {
      string += String(format: "%02.2hhx", arguments: [buffer[i]])
    }

    return string
  }
}