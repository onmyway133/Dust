# Dust

❤️ Support my app ❤️ 

- [Push Hero - pure Swift native macOS application to test push notifications](https://www.producthunt.com/posts/push-hero-2)
- [PastePal - Pasteboard, note and shortcut manager](https://www.producthunt.com/posts/pastepal)
- [Frame recorder - Recorder gif and video with frame](https://www.producthunt.com/posts/frame-recorder)
- [Alias - App and file shortcut manager](https://www.producthunt.com/posts/alias-shortcut-manager)
- [Other apps](https://onmyway133.github.io/projects/)

❤️❤️😇😍🤘❤️❤️

Unofficial, simple push notification

[![CI Status](http://img.shields.io/travis/onmyway133/Dust.svg?style=flat)](https://travis-ci.org/onmyway133/Dust)
[![Version](https://img.shields.io/cocoapods/v/Dust.svg?style=flat)](http://cocoadocs.org/docsets/Dust)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Dust.svg?style=flat)](http://cocoadocs.org/docsets/Dust)
[![Platform](https://img.shields.io/cocoapods/p/Dust.svg?style=flat)](http://cocoadocs.org/docsets/Dust)

![](Screenshots/Banner.png)

The official SDKs can do many things

- Register device token. This is crucial for the notification to get from `your backend -> APNS -> device`
- Manage player id, user id, arn, ...This is used to associate with device token
- Manager tag, topic, subscription, segments, ...This is used to group a set of device tokens
- Do swizzling, update your application badge number, change your user notification settings, ... without your knowing about that
- Some other fancy stuffs

`Dust` does only one thing, which is push notification handling. The rest is under your control

### OneSignal

```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
  OneSignal.appID = ""
}

func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
  OneSignal.handleDeviceToken(deviceToken)
}
```

### Urban Airship
### Amazon SNS
### Firebase Notifications

## Installation

**Dust** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Dust'
```

**Dust** is also available through [Carthage](https://github.com/Carthage/Carthage).
To install just write into your Cartfile:

```ruby
github "onmyway133/Dust"
```

**Dust** can also be installed manually. Just download and drop `Sources` folders in your project.

## Author

Khoa Pham, onmyway133@gmail.com

## Contributing

We would love you to contribute to **Dust**, check the [CONTRIBUTING](https://github.com/onmyway133/Dust/blob/master/CONTRIBUTING.md) file for more info.

## License

**Dust** is available under the MIT license. See the [LICENSE](https://github.com/onmyway133/Dust/blob/master/LICENSE.md) file for more info.
