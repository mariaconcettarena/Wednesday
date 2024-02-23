//
//  Scanning.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.

import Foundation
import SwiftUI
import AVFoundation
import Combine


//CODICE A BARRE SCANSIONATO -> variabile 'code'


struct Product: Codable{
    let barcode: String
    let name: String
    let company: String
    let description: String
    let image: String
    let category: String
    let country: String
    let isCrueltyFree: Bool
    let others: String
}
let previewLayer = AVCaptureVideoPreviewLayer()

struct Scanning: View {
    @State private var isShowingScanner = false
    @State private var scannedCode: String?
    
    
    @State public var product: Product?
    @Binding public var chronology: [Product]
    @Binding public var favourites: [Product]
    
    
    
    var body: some View {
        
        VStack{
            Button(action: {
                isShowingScanner = true
            }) {
                Image(systemName: "barcode.viewfinder")
                Text("SCAN PRODUCT")
                
            } .foregroundColor(.white)
                .frame(width: 280, height: 50)
                .background(Color.accentColor)
                .cornerRadius(12)
            
            
            VStack {
                if scannedCode != nil {
                    if  let data = product {
                        // Text("BARCODE: \(data.barcode)")
                        // Text("Name: \(data.name)")
                        // Text("Company: \(data.company)")
                        // Text("Description: \(data.description)")
                        //  Text("Category: \(data.category)")
                        //  Text("Country: \(data.country)")
                        // Text("IsCrueltyFree?: \(data.isCrueltyFree == true ? "Yes" : data.isCrueltyFree == false ? "No" : "Unknown")")
                        // Text("Others: \(data.others)")
                        
                       
                        CardScan(prod: data)
                    }
                    else {
                        Text("Data not found")
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingScanner) {
            ScannerView(scannedCode: $scannedCode)
            
        }
        .onReceive(Just(scannedCode)) { code in
            guard let code = code else { return }
            fetchDataFromURL(barcode: code)
            isShowingScanner = false
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
                DispatchQueue.main.async
                {
                    self.product = decodedData
                    
                    //se nella cronologia non è presente il barcode, viene aggiunto una sola volta
                    if(!(chronology.contains(where: {$0.barcode == self.product?.barcode}))){
                        chronology.append(self.product!)
                    }
                }
            } catch {
                print("Errore durante la decodifica dei dati:", error)
                self.product=nil
            }
        }
        task.resume()
    }
}


//FUNZIONI PER LA FOTOCAMERA
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
            print("Codice a barre scansionato:", code)
            parent.scannedCode = code
        }
    }
}


//CARD CHE COMPARE APPENA SCANSIONO
/*struct CardScan : View{
    
    @State public var prod: Product
    
    var body : some View{
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(radius: 5).frame(width:350,height:120)
            
            RoundedRectangle(cornerRadius: 20).foregroundColor(verdeCard) .shadow(radius: 5).frame(width:100,height:100).offset(x:-110,y:0)
            
            Text(prod.name).foregroundColor(.black).font(.largeTitle)
            if let decodedImage = self.decodeBase64ToImage(base64String: prod.image) {
                Image(uiImage: decodedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding()
            }
            
        }.background(Color.clear)
    }
    
    
    func decodeBase64ToImage(base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String) else {
            return nil
        }
        return UIImage(data: imageData)
    }
}*/

struct CardScan : View{
    @State public var prod: Product
    
    
    var body : some View{
        VStack{
            
            ZStack{
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .shadow(radius: 5).frame(width:350,height:120)
                
                HStack{
                    ZStack{//QUADRATO VERDE + FOTO
                        RoundedRectangle(cornerRadius: 20).foregroundColor(verdeCard) .shadow(radius: 5).frame(width:100,height:100).padding()
                        
                        if let decodedImage = self.decodeBase64ToImage(base64String: prod.image) {
                            Image(uiImage: decodedImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                                .padding()
                        }
                    }
                    VStack{ //NOME + ISCRUELTYFREE
                        Text(prod.name).foregroundColor(.black).font(.title3).bold().scaleEffect()
                        
                        HStack{
                            Image("BunnyHome").resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            
                            Text("IsCrueltyFree?  \(prod.isCrueltyFree == true ? "Yes" : prod.isCrueltyFree == false ? "No" : "Unknown")")
                        }
                    }.padding()
                }
                
            }.background(Color.clear)
        }.offset(x:0,y:100)
    }
    
    
    func decodeBase64ToImage(base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String) else {
            return nil
        }
        return UIImage(data: imageData)
    }
}









//...

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
        let previewWidth: CGFloat = 400
        let previewHeight: CGFloat = 600
        // Calculate the center position of the screen
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let centerX = (screenWidth - previewWidth) / 2
        let centerY = (screenHeight - previewHeight) / 2
        
        // Set the frame of the preview layer
        previewLayer.frame = CGRect(x: centerX, y: centerY, width: previewWidth, height: previewHeight)
        previewLayer.session = captureSession
        //previewLayer.frame = view.layer.bounds
        //previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            captureSession.stopRunning()
            DispatchQueue.main.async {
                // Remove all sublayers including the previewLayer
                self.view.layer.sublayers?.forEach { $0.removeFromSuperlayer()
                    
                }
                // Inform the delegate of the scanned code
                self.delegate?.didScanCode(stringValue)
            }
            
            // delegate?.didScanCode(stringValue)
        }
    }
    
    
}






/*#Preview {
 Scanning()
 }*/


