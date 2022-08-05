import UIKit

@objc(RCTCamaraManager)
class RCTCamaraManager: RCTViewManager {
  let wrapperView = UIView()
  let cameraView = CameraView()
  
  override func view() -> UIView! {
    // CamraViewはframeを指定している。本来これはRN的にはNG。もしこうしたい場合は何も指定してないviewでラップしたものをview()内で返してあげるといい。
    // 実際にこれをしないと、ネイティブ側で撮影ボタンを追加した時にタップに反応しなかった。
    // https://reactnative.dev/docs/native-components-ios.html#ios-mapview-example
    wrapperView.addSubview(cameraView)
    return wrapperView
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }

  @objc
  func capture() {
    let camera = CameraView()
    camera.capture()
  }
  
  @objc
  func call(_ node: NSNumber) {
    print("Called😏")
    let component = bridge.uiManager.view(forReactTag: node) as! CameraView
    component.call()
  }
}
