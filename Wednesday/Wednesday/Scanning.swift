//
//  Scanning.swift
//  Wednesday
//
//  Created by Maria Concetta on 12/02/24.

import SwiftUI
import AVFoundation
import Combine
import CoreHaptics


//Per salvare e trasformare in stringa la data di scansione
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()



struct Product: Codable{
    let barcode: String
    let name: String
    let company: String
    let description: String
    let image: String
    var category: String
    let country: String
    let isCrueltyFree: Bool
    var others: String //contiene la data di scansione del prodotto
}



let previewLayer = AVCaptureVideoPreviewLayer()

struct Scanning: View {
    @State private var isShowingScanner = false
    @State private var scannedCode: String?
    
    @Binding public var chronology: [Product]
    @Binding public var favourites: [Product]
    
    @Binding public var product : Product
    @State public var found : Bool = true
    @Binding public var deleteChronology : Bool
    
    @State public var isWaiting: Bool = true
    
    @State public var isRotating : Bool = false
    
    var body: some View {
       // NavigationView{
            
            VStack{
                Button(action: {
                    isShowingScanner = true
                    deleteChronology = false
                }) {
                    
                    Image(systemName: "barcode.viewfinder")
                    Text("SCAN PRODUCT")
                    
                } .foregroundColor(.white)
                    .frame(width: 280, height: 50)
                    .background(Color.accentColor)
                    .cornerRadius(12)
                    .offset(y:90)
                
                
                VStack {
                    if (scannedCode != nil)  {
                        
                        if found {
                            
                            if isWaiting{
                                Image(systemName: "arrow.clockwise.circle")
                                    .resizable().frame(width: 50, height: 50).foregroundColor(verde).padding()
                                    .rotationEffect(.degrees(isRotating ? 360 : 0))
                                    .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
                                    .offset(y:100)
                                    .onAppear{
                                        self.isRotating = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                            withAnimation {
                                                isWaiting = false
                                            }
                                        }
                                    }
                            }
                            else{
                                CardScan(prod: $product)
                                
                            }
                            
                        }
                        
                        else {
                            VStack{
                                Text("Sorry, this product is not in our database...")
                                    .opacity(found ? 0 : 1) // Nasconde il testo se found è true
                                Image("notfound").resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)//.shadow(radius: 10)
                            }.offset(y:100)
                            
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
                
                
                if(!(chronology.contains(where: {$0.barcode == self.product.barcode})) && !deleteChronology && found){
                    
                    //In questo punto prendo la data attuale e la metto nel campo product.others
                    let now = Date()
                    let formattedDate = dateFormatter.string(from: now)
                    self.product.others = formattedDate
                    chronology.append(self.product)
                    saveProductsToUserDefaults()
                }
            }
      //  }.navigationTitle("Scan")
    }
    
    //save
    func saveProductsToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(chronology) {
            UserDefaults.standard.set(encoded, forKey: "products")
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
                    self.product = decodedData //riempimento prodotto appena lo scansiona
                    found = true//se nella cronologia non è presente il barcode, viene aggiunto una sola volta
                }
                
            } catch {
                print("Errore durante la decodifica dei dati:", error)
                DispatchQueue.main.async {
                    self.found = false // Imposto found a false se il prodotto non è stato trovato
                    isWaiting = true
                }
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

struct CardScan : View{
    @Binding public var prod: Product
    
    var body : some View{
        VStack{
            
            ZStack{
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .shadow(radius: 5).frame(width:350,height:120)
                
                
                NavigationLink(destination: ProductView(product: $prod)){
                    
                    HStack{
                        ZStack{//QUADRATO VERDE + FOTO
                            RoundedRectangle(cornerRadius: 20).foregroundColor(verdeCard) .shadow(radius: 5).frame(width:100,height:100).padding().offset(x:-5)
                            
                            if let decodedImage = self.decodeBase64ToImage(base64String: prod.image) {
                                Image(uiImage: decodedImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 90, height: 90)
                                    .padding().offset(x:-5)
                            }
                        }
                        VStack{ //NOME + ISCRUELTYFREE
                            Text(prod.name).foregroundColor(.black).font(.title3).bold().scaleEffect()
                            
                            HStack{ //cambio l'immagine del coniglio in base alla categoria del prodotto scansionato
                                if prod.isCrueltyFree{
                                    if prod.category == "Hair"{
                                        Image("Hair").resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    }
                                    else if prod.category == "Bodycare"{
                                        Image("Bodycare").resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    }else if prod.category == "Makeup"{
                                        Image("Makeup").resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    }else if prod.category == "Skincare"{
                                        Image("Skincare").resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    }else{
                                        Image("Perfume").resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    }
                                }
                                else{
                                    Image("sad").resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                }
                                
                               
                                
                                Text((prod.isCrueltyFree == true ? "Cruelty-free" : prod.isCrueltyFree == false ? "Not cruelty-free" : "Unknown"))
                            }
                        }.padding()
                    }
                    
                }.background(Color.clear)
                
            }
            
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
    
    var hapticEngine: CHHapticEngine? //per la vibrazione
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCamera()
        
        setupHaptics()
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
    
    
    //vibrazione
    func setupHaptics() {
        // Controllo della disponibilità dell'haptic engine
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            // Creazione dell'haptic engine
            hapticEngine = try CHHapticEngine()
            
            // Avvio dell'haptic engine
            try hapticEngine?.start()
        } catch let error {
            print("Errore durante l'inizializzazione dell'haptic engine: \(error.localizedDescription)")
        }
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
                
                // Attiva una piccola vibrazione
                self.triggerHapticFeedback()
            }
            
            // delegate?.didScanCode(stringValue)
        }
    }
    
    //
    func triggerHapticFeedback() {
        // Controlla se l'haptic engine è disponibile
        guard let hapticEngine = hapticEngine else { return }
        
        // Definisci un evento haptic con intensità e durata maggiori
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: 1), // Intensità massima
            CHHapticEventParameter(parameterID: .hapticSharpness, value: 1) // Massima nitidezza
        ], relativeTime: 0, duration: 0.5) // Durata della vibrazione: 0.5 secondi
        
        do {
            // Crea un pattern haptic semplice con un singolo evento
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            
            // Crea un player haptic con il pattern creato
            let player = try hapticEngine.makePlayer(with: pattern)
            
            // Avvia la riproduzione del feedback haptic
            try player.start(atTime: CHHapticTimeImmediate)
        } catch let error {
            print("Errore durante la riproduzione del feedback haptic: \(error.localizedDescription)")
        }
    }
    
    
    
    
    
    
    
    
}






