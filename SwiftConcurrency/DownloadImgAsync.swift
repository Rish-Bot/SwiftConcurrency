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
    
    // downlaod image with completion handler and result enum : small changes
    
  /*  func downlaodImageWithCompletionHandlerWithResultEnum(completionHandler:@escaping (Result<UIImage, Error>) -> ()){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let image = UIImage(data: data),
                let resonse = response as? HTTPURLResponse,
                resonse.statusCode >= 200 && resonse.statusCode < 300,
                error == nil
            else {
                completionHandler(.failure(error?.localizedDescription))
                return
            }
            completionHandler(.success(image))
           
        }
        .resume()
    }*/
    
    func downlaodImageWithCompletionHandlerResultEnum(from url: URL, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard
                let data = data,
                let image = UIImage(data: data),
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                let responseError = NSError(domain: "Invalid Response", code: 0, userInfo: nil)
                completionHandler(.failure(responseError))
                return
            }
            
            completionHandler(.success(image))
        }
        .resume()
    }
}

//viewModel
class DownloadImgAsyncVM: ObservableObject {
    @Published var image: UIImage?
    let url = URL(string: "https://picsum.photos/200")!
    
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
    
    func fetchImageWithCompletionHandlerResultEnum(){
        
        self.dataManager.downlaodImageWithCompletionHandlerResultEnum(from: url) { result in
            switch result {
                case .success(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
            case .failure(let error):
                print(error)
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
                viewModel.fetchImageWithCompletionHandlerResultEnum()
            }.padding()
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .onAppear {
            viewModel.fetchImageWithCompletionHandlerResultEnum()
        }
        
        
    }
}


#Preview {
    DownloadImgAsync()
}
