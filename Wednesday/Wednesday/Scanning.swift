//
//  Scanning.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.
//

import Foundation
import SwiftUI
import AVFoundation
import Combine


struct Product: Codable {
    let barcode: String
    let company: String
    let description: String
    //let image: String
    let category: String
    let country: String
    let standard: Bool
    let others: String
}


struct Scanning: View {
    @State private var isShowingScanner = false
    @State private var scannedCode: String?
    @State private var product: Product?
    
    
    var body: some View {
        VStack {
            if let code = scannedCode {
                
                if let data = product {
                    Text("BARCODE: \(data.barcode)")
                    Text("Company: \(data.company)")
                    Text("Description: \(data.description)")
                    Text("Category: \(data.category)")
                    Text("Country: \(data.country)")
                    Text("IsCrueltyFree?: \(data.standard == true ? "Yes" : data.standard == false ? "No" : "Unknown")")
                    Text("Others: \(data.others)")

                    
                } else {
                    Text("Data not found")
                }
                
                
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
        .onReceive(Just(scannedCode)) { code in
                    guard let code = code else { return }
                    fetchDataFromURL(barcode: code)
                }
    }
    
    
    // Funzione per ottenere i dati dall'URL
   private func fetchDataFromURL(barcode: String) {
        let baseURL = "https://myapisrv.obbar.it/api/Product/getProductByBarcode?barcode="
        
        guard let url = URL(string: baseURL + barcode) else {
            print("URL non valido")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Errore durante il recupero dei dati:", error?.localizedDescription ?? "Errore sconosciuto")
                return
            }

            do {
                // Decodifica dei dati JSON nella struttura Product e aggiornamento della proprietà @State
                let decodedData = try JSONDecoder().decode(Product.self, from: data)
                DispatchQueue.main.async {
                    self.product = decodedData
                }
            } catch {
                print("Errore durante la decodifica dei dati:", error)
            }
        }

        task.resume()
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


