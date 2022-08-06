import UIKit
import AVFoundation
import Foundation

@objc(RCTCamaraManager)
class RCTCamaraManager: RCTViewManager {
  override func view() -> UIView! {
    // 他のUIVewでラップしてリターンした方がいい場合もある。
    // https://reactnative.dev/docs/native-components-ios.html#ios-mapview-example
    return CameraView()
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }

  @objc
  func capture(_ node: NSNumber) {
    let component = getCameraView(tag: node)
    component.capture()
  }
  
  func getCameraView(tag: NSNumber) -> CameraView {
    return bridge.uiManager.view(forReactTag: tag) as! CameraView
  }
}
