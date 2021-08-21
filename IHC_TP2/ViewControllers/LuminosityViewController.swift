//
//  LuminosityViewController.swift
//  IHC_TP2
//
//  Created by Henrique Conte on 21/08/21.
//

import UIKit
import AVFoundation


class LuminosityViewController: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var luminosityLabel: UILabel!
    let camera = CameraFunctions(camType: "backCamera")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                self.camera.setupAndStartCaptureSession(previewView: self.cameraView, bufferDelegate: self)
            }
        }
    }
    
    private func getBrightness(sampleBuffer: CMSampleBuffer) -> Double {
        let rawMetadata = CMCopyDictionaryOfAttachments(allocator: nil, target: sampleBuffer, attachmentMode: CMAttachmentMode(kCMAttachmentMode_ShouldPropagate))
        let metadata = CFDictionaryCreateMutableCopy(nil, 0, rawMetadata) as NSMutableDictionary
        let exifData = metadata.value(forKey: "{Exif}") as? NSMutableDictionary
        let brightnessValue : Double = exifData?[kCGImagePropertyExifBrightnessValue as String] as! Double
        return brightnessValue
    }
    
    @IBAction func nextButtonTouched(_ sender: Any) {
        performSegue(withIdentifier: "showGyroscopeVC", sender: nil)
    }
}

extension LuminosityViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        DispatchQueue.main.async {
            self.luminosityLabel.text = "Luminosidade: \(self.getBrightness(sampleBuffer: sampleBuffer))"
        }
    }
}
