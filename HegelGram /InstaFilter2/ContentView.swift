//
//  ContentView.swift
//  InstaFilter2
//
//  Created by Pavlo Theodoridis on 2022-11-29.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    let imageNames = ["Frame1", "Frame2", "Frame3"]
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    @State private var showingFrameSheet = false
    
    
    @State var selectedFrame : String?
    
    var body: some View {
        NavigationView {
            VStack {
                
                ZStack {
                    Rectangle()
                        .fill(Color("HegelColor1"))
                        .frame(height: 350)
                        .frame(width: 350)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                            .scaledToFill()
                            .frame(width: 350, height: 350, alignment: .center)
                            .clipped()
                    
                    
                    if selectedFrame != nil {
                        Image(selectedFrame!)
                            .resizable()
                            .scaledToFit()
                                .scaledToFill()
                                .frame(width: 350, height: 350, alignment: .center)
                    }
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in applyProcessing() }
                }
                .padding(.vertical)
                
                HStack {
                    Spacer()
                    Button("Change Filter") {
                        showingFilterSheet = true
                    }
                    /* .font(.headline)
                     .foregroundColor(Color("HegelColor1"))
                     .frame(height: 55)
                     .frame(maxWidth: .infinity)
                     .background(Color("HegelColor2"))
                     .cornerRadius(10)
                     .shadow(color: Color("HegelColor2").opacity(0.8), radius: 10, x: 0.0, y: 10)
                     .buttonStyle(PressableButtonStyle())
                     .padding(40)*/
                    
                    Spacer()
                    
                   Button("Add Frame"){
                        showingFrameSheet = true
                    }
                    /* .font(.headline)
                     .foregroundColor(Color("HegelColor1"))
                     .frame(height: 55)
                     .frame(maxWidth: .infinity)
                     .background(Color("HegelColor2"))
                     .cornerRadius(10)
                     .shadow(color: Color("HegelColor2").opacity(0.8), radius: 10, x: 0.0, y: 10)
                     .buttonStyle(PressableButtonStyle())
                     .padding(40)*/
                    
                    Spacer()
                    
                    Button("Save", action: save)
                        //.disabled(inputImage == nil)
                       /* .font(.headline)
                        .foregroundColor(Color("HegelColor1"))
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color("HegelColor2"))
                        .cornerRadius(10)
                        .shadow(color: Color("HegelColor2").opacity(0.8), radius: 10, x: 0.0, y: 10)
                        .buttonStyle(PressableButtonStyle())
                        .padding(40)*/
                    Spacer()
                }
            }
            .padding([.horizontal, .bottom])
            
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .sheet(isPresented: $showingFrameSheet) {
                FrameSheet(imageNames: ["Frame1", "Frame2", "Frame3", "Dark Guillotine"], selectFrame: $selectedFrame)
                Button("Cancel", role: .cancel) {  }
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixelate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) {  }
                
                //CIFilter. checka systemets filter
            }
            .navigationTitle("Frame Screen")
            .navigationBarItems(
                leading: Image(systemName: "hare.fill"),
                trailing: Image(systemName: "person"))
            /*
            .confirmationDialog("Select a frame", isPresented: $showingFrameSheet) {
                Button("frame1") {  }
                
            }
            */
          }
       }
    
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
        
    }
    
    func loadImageWithFrame() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
        
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
