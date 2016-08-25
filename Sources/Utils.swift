//
//  Utils.swift
//  Dust
//
//  Created by Khoa Pham on 24/08/16.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import UIKit

struct Utils {

  static func parseDeviceToken(data: NSData) -> String {
    let buffer = UnsafePointer<CChar>(data.bytes)
    var string = ""

    for i in 0..<data.length {
      string += String(format: "%02.2hhx", arguments: [buffer[i]])
    }

    return string
  }

  static func deviceModel() -> String {
    var systemInfo = utsname()
    uname(&systemInfo)
    var v = systemInfo.machine

    var deviceModel = ""
    let _ = withUnsafePointer(&v) {
      deviceModel = String(UTF8String: UnsafePointer($0)) ?? ""
    }

    return deviceModel
  }

  static func systemVersion() -> String {
    let version = NSProcessInfo.processInfo().operatingSystemVersion

    return "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
  }

  static func language() -> String {
    return NSLocale.preferredLanguages().first!
  }

  static func timezone() -> Int {
    return NSTimeZone.localTimeZone().secondsFromGMT
  }

  static func soundFiles() -> [String] {
    guard let resourcePath = NSBundle.mainBundle().resourcePath
      else { return [] }

    let files = try? NSFileManager.defaultManager()
      .contentsOfDirectoryAtPath(resourcePath)
      .filter {
        return $0.hasSuffix(".wav") || $0.hasSuffix(".mp3")
      }

    return files ?? []
  }

  static func netType() -> Int {
    // Reachability
    return 0
  }

  static func notificationTypes() -> Int {
    if UserDefaults.disableSubscription {
      return -2
    }

    if UserDefaults.deviceToken != nil {
      return Int(UIApplication.sharedApplication().currentUserNotificationSettings()?.types.rawValue ?? 0)
    }

    return -1
  }
}