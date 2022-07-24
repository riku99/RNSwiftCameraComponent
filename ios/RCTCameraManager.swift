import UIKit

@objc(RCTCamaraManager)
class RCTCamaraManager: RCTViewManager {
  override func view() -> UIView! {
    return CameraView()
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
