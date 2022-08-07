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
  
  @objc var flash = false
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    setupCaptureSession()
    setupDevice()
    setupInputOutput()
    setupPreviewLayer()
    captureSession.startRunning()
  }
  
  // Propsが全てセットされてから実行されるメソッド。RCTViewに定義されている
  // RCTViewManagerのview()が return [RCTView new]; となってるから、RCTViewManagerを継承しているクラスのview()でreturnされているUIViewでオーバーライドできる
  override func didSetProps(_ changedProps: [String]!) {
    print("😄 flash is " + String(flash))
  }
  
  @objc
  func capture() {
    let settings = AVCapturePhotoSettings()
    settings.flashMode = flash ? .on : .off
    self.photoOutput?.capturePhoto(with: settings, delegate: self as AVCapturePhotoCaptureDelegate)
  }
  
  func setupPreviewLayer() {
    // frameをネイティブ側で指定しないとプレビュー画面表示されない(?)
    self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    
    cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
    cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
    cameraPreviewLayer?.frame = layer.bounds
    
    self.layer.insertSublayer(cameraPreviewLayer!, at: 0)
  }
  
  func setupInputOutput() {
      do {
          let caputureDeviceInput = try AVCaptureDeviceInput(device: currentDevice!)
          
          captureSession.addInput(caputureDeviceInput)
          
          photoOutput = AVCapturePhotoOutput()
          
          let outPutPhotoSettings = [AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])]
          photoOutput!.setPreparedPhotoSettingsArray(outPutPhotoSettings, completionHandler: nil)
          captureSession.addOutput(photoOutput!)
      } catch {
          print(error)
      }
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

extension CameraView: AVCapturePhotoCaptureDelegate {
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    if let imageData = photo.fileDataRepresentation() {
      let uiImage = UIImage(data: imageData)
      UIImageWriteToSavedPhotosAlbum(uiImage!, nil, nil, nil)
    }
  }
}
