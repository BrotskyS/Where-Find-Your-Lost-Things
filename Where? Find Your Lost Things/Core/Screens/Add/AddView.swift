//
//  AddView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 11.09.2022.
//

import SwiftUI
import MapKit
import PhotosUI

struct AddView: View {
    @ObservedObject var vm = AddViewModel()
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("Background").ignoresSafeArea()
                
                content
            }
            .navigationTitle("Create ad")
        }
    }
    
    var content: some View {
        ScrollView{
            VStack(spacing: 20){
                Picker("Add type", selection: $vm.addType){
                    Text("I Lost")
                        .tag(AddType.lost)
                    Text("I Found")
                        .tag(AddType.found)
                }
                .pickerStyle(.segmented)
                
                images
                
                title
                
                description
                
                location
                
                phoneInput
                
                saveButton
                
                Spacer()
            }
            .padding()
        }
    }
    
    var images: some View {
        VStack{
            VStack(spacing: 20){
                if let image = vm.images.first {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Image(systemName: "text.below.photo")
                        .font(.title2)
                    
                    Text("Add photo")
                        .font(.headline)
                }
             
            }
            .frame(maxWidth: .infinity, idealHeight:  200)
            .background(.ultraThinMaterial)
            
            
            HStack{
                ForEach(1..<5, id: \.self){ item in
                    ZStack{
                        if let image = vm.images[safe: item] {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: 50)
                        } else {
                            Image(systemName: "plus.circle.fill")
                                .frame(maxWidth: .infinity)
                                .padding()
                              
                        }
                    }
                    .background(.ultraThinMaterial)
                }
            }
        }
        
        .cornerRadius(5)
        .onTapGesture {
            vm.picker = true
        }
        .sheet(isPresented: $vm.picker, content: {
            ImagePicker(images: $vm.images, picker: $vm.picker)
        })
    }
    
    var title: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Ad title*")
                .font(.caption)
                .foregroundColor(.gray)
            TextField("I lost my keys", text: $vm.title)
                .padding(10)
                .background(.ultraThinMaterial)
                .cornerRadius(5)
        }
    }
    
    var description: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Describe what you lost")
                .font(.caption)
                .foregroundColor(.gray)
            
            TextEditor(text: $vm.description)
                .padding(10)
                .background(.ultraThinMaterial)
                .frame(maxWidth: .infinity, minHeight: 200)
                .cornerRadius(5)
        }
    }
    
    var location: some View {
        Map(coordinateRegion: $vm.region)
            .frame(maxWidth: .infinity, minHeight: 200)
        
            .overlay(
                HStack{
                    Image(systemName: "mappin")
                    
                    VStack(alignment: .leading) {
                        Text("Your location")
                            .font(.caption2)
                            .foregroundColor(.gray)
                        Text("Тернопіль. Тернопілька область")
                    }
                    
                    Spacer()
                    Image(systemName: "arrow.right")
                }
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                
                
            )
            .cornerRadius(5)
        
        
    }
    
    var phoneInput: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Your Phone Number")
                .font(.caption)
                .foregroundColor(.gray)
            TextField("+38067....", text: $vm.phone)
                .padding(10)
                .background(.ultraThinMaterial)
                .cornerRadius(5)
        }
    }
    
    var saveButton: some View {
        Text("Save")
            .padding()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(Color("AccentColor"))
            .cornerRadius(10)
            .padding(.top, 50)
            
    }
    
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator.init(parent1: self)
    }
    @Binding var images: [UIImage]
    @Binding var picker: Bool
    
  
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 5
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        
        init(parent1: ImagePicker) {
            parent = parent1
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.picker.toggle()
            parent.images = []
            for img in results {
                if img.itemProvider.canLoadObject(ofClass: UIImage.self){
                    img.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        guard let image1 = image else {
                            print("Error: \(error)")
                            return
                        }
                        
                        DispatchQueue.main.async {
                            self.parent.images.append(image1 as! UIImage)
                        }
                   
                    }
                }
                else {
                    print("Cant load image")
                }
            }
        }
    }
}


extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
