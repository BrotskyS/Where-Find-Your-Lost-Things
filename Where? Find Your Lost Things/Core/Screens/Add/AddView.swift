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
        CustomNavBarView(title: "Create ad"){
                ZStack{
                   
                    NavigationLink(destination: SetPinMapView(currentRegion: $vm.region, region: vm.region), isActive: $vm.showFullMap) {
                        Color.clear
                    }
                    
                    Color("Background").ignoresSafeArea()
                    
                    content
                    
                }        
              
            }
    }
    
    var content: some View {
        ScrollView{
            VStack(spacing: 20){
                Picker("Add type", selection: $vm.itemType){
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
                
                priveInput
                
                
                Button{
                    vm.save()
                } label: {
                    saveButton
                }
                .disabled(!vm.canSubmit)
                
                
                
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
                        .aspectRatio(contentMode: .fill)
                        .showPreview(image: image) {
                            
                        }
                } else {
                    Image(systemName: "text.below.photo")
                        .font(.title2)
                    
                    Text("Add photo")
                        .font(.headline)
                }
                
            }
            .frame(maxWidth: .infinity, idealHeight:  200)
            .clipped()
            .background(Color("Secondary"))
            
            
            HStack{
                ForEach(1..<5, id: \.self){ item in
                    ZStack{
                        if let image = vm.images[safe: item] {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: 50)
                        } else {
                            Image(systemName: "plus.circle.fill")
                                .frame(maxWidth: .infinity)
                                .padding()
                            
                        }
                    }
                    .background(Color("Secondary"))
                    .clipped()
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
            
            HStack{
                TextField("I lost my keys", text: $vm.title)
                    .padding(10)
                    .padding(.trailing, 45)
                    .background(Color("Secondary"))
                    .cornerRadius(5)
            }
            
        }
        .overlay {
            Text("\(vm.title.count)/\(vm.maxTitleCountText)")
                .foregroundColor(vm.title.count > vm.maxTitleCountText ? .red : .gray)
                .font(.caption)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(10)
            
        }
    }
    
    var description: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Describe what you lost")
                .font(.caption)
                .foregroundColor(.gray)
            
            if #available(iOS 16.0, *) { // UITextView.appearance().backgroundColor = .clear not work in IOS 16
                TextEditor(text: $vm.description)
                    .padding(10)
                    .background(Color("Secondary"))
                    .frame(maxWidth: .infinity, minHeight: 200)
                    .cornerRadius(5)
                    .scrollContentBackground(.hidden)
            }else {
                TextEditor(text: $vm.description)
                    .padding(10)
                    .background(Color("Secondary"))
                    .frame(maxWidth: .infinity, minHeight: 200)
                    .cornerRadius(5)
            }
        }
        .overlay {
            Text("\(vm.description.count)/\(vm.maxDescriptionCountText)")
                .foregroundColor(vm.description.count > vm.maxDescriptionCountText ? .red : .gray)
                .font(.caption)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(10)
            
        }
    }
    
    var location: some View {
        Map(coordinateRegion: $vm.region)
            .disabled(true)
            .frame(maxWidth: .infinity, minHeight: 200)
        
            .overlay(
                HStack{
                    Image(systemName: "mappin")
                    
                    VStack(alignment: .leading) {
                        Text("Location whene you lost your item")
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
            .overlay(
                CustonMapPin()
            )
        
            .cornerRadius(5)
            .onTapGesture {
                vm.showFullMap = true
            }
        
        
    }
    
    var phoneInput: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Your Phone Number")
                .font(.caption)
                .foregroundColor(.gray)
            TextField("+38067....", text: $vm.phoneNumber)
                .padding(10)
                .background(Color("Secondary"))
                .cornerRadius(5)
                .keyboardType(.phonePad)
        }
    }
    
    var priveInput: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Specify the reward (option)")
                .font(.caption)
                .foregroundColor(.gray)
            TextField("0$", text: $vm.price)
                .padding(10)
                .background(Color("Secondary"))
                .cornerRadius(5)
                .keyboardType(.numberPad)
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
            .opacity(vm.canSubmit ? 1 : 0.7)
            .animation(.default, value: vm.canSubmit)
        
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


