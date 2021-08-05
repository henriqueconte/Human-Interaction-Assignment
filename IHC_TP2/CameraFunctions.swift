import Foundation
import AVFoundation
import UIKit

class CameraFunctions {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var videoOutput : AVCaptureVideoDataOutput!
    var backCamera : AVCaptureDevice!
    var frontCamera : AVCaptureDevice!
    var backInput : AVCaptureInput!
    var frontInput : AVCaptureInput!
    var cameraType : String!
    
    init(camType: String) {
        cameraType = camType
    }
    
    func setupAndStartCaptureSession(previewView: UIView, bufferDelegate: AVCaptureVideoDataOutputSampleBufferDelegate){
        Dispatch.DispatchQueue.global(qos: .userInitiated).async{
            self.captureSession = AVCaptureSession()
            self.captureSession.beginConfiguration()
            
            if self.captureSession.canSetSessionPreset(.photo) {
                self.captureSession.sessionPreset = .photo
            }
            self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
            
            self.setupInputs()
            
            Dispatch.DispatchQueue.main.async {
                self.setupPreviewLayer(previewView: previewView)
            }
            
            self.setupOutput(bufferDelegate: bufferDelegate)
            
            self.captureSession.commitConfiguration()
            self.captureSession.startRunning()
        }
    }
    
    private func setupPreviewLayer(previewView: UIView){
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewView.layer.addSublayer(previewLayer)
        previewLayer.frame = previewView.bounds
    }
    
    private func setupOutput(bufferDelegate: AVCaptureVideoDataOutputSampleBufferDelegate){
        videoOutput = AVCaptureVideoDataOutput()
        let videoQueue = Dispatch.DispatchQueue(label: "videoQueue", qos: .userInteractive)
        videoOutput.setSampleBufferDelegate(bufferDelegate, queue: videoQueue)
        
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        } else {
            fatalError("could not add video output")
        }
        
        videoOutput.connections.first?.videoOrientation = .portrait
        if cameraType == "frontCamera"{
            videoOutput.connections.first?.isVideoMirrored = true
        }
    }
    
    private func setupInputs(){
        
        if cameraType == "frontCamera"{
            if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
                frontCamera = device
            } else {
                fatalError("no front camera")
            }
            
            guard let fInput = try? AVCaptureDeviceInput(device: frontCamera) else {
                fatalError("could not create input device from front camera")
            }
            frontInput = fInput
            if !captureSession.canAddInput(frontInput) {
                fatalError("could not add front camera input to capture session")
            }
            captureSession.addInput(frontInput)
        }else if cameraType == "backCamera"{
            if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
                backCamera = device
            } else {
                fatalError("no back camera")
            }
            
            guard let bInput = try? AVCaptureDeviceInput(device: backCamera) else {
                fatalError("could not create input device from back camera")
            }
            backInput = bInput
            if !captureSession.canAddInput(backInput) {
                fatalError("could not add back camera input to capture session")
            }
            captureSession.addInput(backInput)
        }else{
            fatalError("could not set camera type")
        }
    }
}

