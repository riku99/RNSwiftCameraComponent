import UIKit

@objc(RCTCamaraManager)
class RCTCamaraManager: RCTViewManager {
  override func view() -> UIView! {
    let label = UILabel()
    label.text = "Swift Camera"
    label.textAlignment = .center
    return label
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
