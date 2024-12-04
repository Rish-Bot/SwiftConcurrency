//
//  DownloadImgAsync.swift
//  SwiftConcurrency
//
//  Created by Hari on 04/12/24.
//

import SwiftUI

//DataManager / Imageloader
class DownloadImgAsyncDataManager {
    
    let url = URL(string: "https://picsum.photos/200")!
    
    func downlaodImageWithCompletionHandler(completionHandler:@escaping (UIImage?, Error?) -> ()){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let image = UIImage(data: data),
                let resonse = response as? HTTPURLResponse,
                resonse.statusCode >= 200 && resonse.statusCode < 300,
                error == nil
            else {
                completionHandler(nil, error)
                return
            }
            
            completionHandler(image, nil)
        }
        .resume()
    }
    
}

//viewModel
class DownloadImgAsyncVM: ObservableObject {
    @Published var image: UIImage?
    let dataManager: DownloadImgAsyncDataManager = DownloadImgAsyncDataManager()
    
    func fetchImage() {
        self.image = UIImage(systemName: "heart.fill")
    }
    
    func fetchImageWithCompletionHandler() {
        self.dataManager.downlaodImageWithCompletionHandler {[weak self] image, error in
            
            DispatchQueue.main.async {
                self?.image = image
            }
            
        }
    }
}

struct DownloadImgAsync: View {
    @StateObject private var viewModel = DownloadImgAsyncVM()
    var body: some View {
        VStack{
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.green,.blue,.red)
                    .frame(width: 300, height: 400)
                    .padding()
            }
            
            Button("New Image") {
                viewModel.fetchImageWithCompletionHandler()
            }.padding()
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .onAppear {
            viewModel.fetchImageWithCompletionHandler()
        }
        
        
    }
}


#Preview {
    DownloadImgAsync()
}
