//
//  Scanning.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import Foundation
import SwiftUI
import AVFoundation

struct Scanning: View {
    @State private var isShowingScanner = false
    @State private var scannedCode: String?
    
    var body: some View {
        VStack {
            if let code = scannedCode {
                Text("Codice a barre scansionato: \(code)")
            } else {
                Button(action: {
                    isShowingScanner = true
                }) {
                    Image(systemName: "barcode.viewfinder")
                    Text("SCAN PRODUCT")
                       
                } .foregroundColor(.white)
                    .frame(width: 280, height: 50)
                    .background(Color.accentColor)
                    .cornerRadius(12)
            }
        }
        .sheet(isPresented: $isShowingScanner) {
            ScannerView(scannedCode: $scannedCode)
        }
    }
}

struct ScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode: String?
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        let scannerViewController = ScannerViewController()
        scannerViewController.delegate = context.coordinator
        return scannerViewController
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, ScannerViewControllerDelegate {
        var parent: ScannerView
        
        init(parent: ScannerView) {
            self.parent = parent
        }
        
        func didScanCode(_ code: String) {
            parent.scannedCode = code
        }
    }
}

protocol ScannerViewControllerDelegate: AnyObject {
    func didScanCode(_ code: String)
}

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    weak var delegate: ScannerViewControllerDelegate?
    var captureSession: AVCaptureSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCamera()
    }
    
    func setupCamera() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        
        captureSession = AVCaptureSession()
        captureSession.addInput(input)
        
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            print("Could not add metadata output")
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            captureSession.stopRunning()
            delegate?.didScanCode(stringValue)
        }
    }
}


#Preview {
    Scanning()
}

