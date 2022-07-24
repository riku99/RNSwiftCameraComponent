import UIKit
import AVFoundation
import Foundation

@objc(CameraView)
class CameraView: UIView {
  var captureSession = AVCaptureSession()
  var mainCamera: AVCaptureDevice?
  var innerCamera: AVCaptureDevice?
  var currentDevice: AVCaptureDevice?
  var photoOutput: AVCapturePhotoOutput?
  var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  // Propsが全てセットされてから実行されるメソッド。RCTViewに定義されている
  // RCTViewManagerのview()が return [RCTView new]; となってるから、RCTViewManagerを継承しているクラスのview()でreturnされているUIViewでオーバーライドできる
  override func didSetProps(_ changedProps: [String]!) {
    setupCaptureSession()
    setupDevice()
  }
  
  func setupDevice () {
      let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
      
      let devices = deviceDiscoverySession.devices
      
      for device in devices {
          if device.position == AVCaptureDevice.Position.back {
              mainCamera = device
          } else if device.position == AVCaptureDevice.Position.front {
              innerCamera = device
          }
      }
      
      currentDevice = mainCamera
  }
  
  func setupCaptureSession() {
    captureSession.sessionPreset = AVCaptureSession.Preset.photo
  }
  
  // UIViewのサブクラスでは必須
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) is not implemented.")
  }
}
