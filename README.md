<p align="center"> <b> SafetyPay is a security payment password demo </b></p>


![language](https://img.shields.io/badge/language-swift-orange.svg)
[![swift  4.0](https://img.shields.io/badge/swift-4.0.3+-blue.svg?style=flat)](https://developer.apple.com/swift/)
![xcode version](https://img.shields.io/badge/xcode-9+-brightgreen.svg)
![build](https://img.shields.io/appveyor/ci/gruntjs/grunt.svg)
![platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)
![https://github.com/ChinaHackers/SafetyPay/blob/master/LICENSE](https://img.shields.io/github/license/ChinaHackers/SafetyPay.svg)
![](https://img.shields.io/github/stars/ChinaHackers/SafetyPay.svg?style=social&label=Star)
[![Twitter Follow](https://img.shields.io/twitter/follow/LiuChuan_.svg?style=social)](https://twitter.com/LiuChuan_)

---


### Safety Pay style

- **Using enumerations to define `safetyPayStyle` types**

```swift
/// 安全支付样式
///
/// - ciphertext: 密文
/// - Plaintext: 明文
enum safetyPayStyle {
    /// 密文
    case ciphertext
    /// 明文
    case plaintext
}
```


### Screencast from our Demo


| ![](https://github.com/ChinaHackers/SafetyPay/raw/master/Screencast/Screencast1.gif) | ![](https://github.com/ChinaHackers/SafetyPay/raw/master/Screencast/Screencast2.gif) | 
| :------------: | :------------: |
| `style = .plaintext` | `style = .ciphertext` | 



## Example:

```swift
import UIKit
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        /*****  SafetyPayView  *****/
        let vi = SafetyPayView(frame: CGRect(x: (view.bounds.width - 300) / 2, y: 200, width: 300, height: 50))
        vi.style = .plaintext
        view.addSubview(vi)
    }
}
```



