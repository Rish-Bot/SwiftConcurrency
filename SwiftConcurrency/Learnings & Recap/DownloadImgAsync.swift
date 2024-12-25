//
//  DownloadImgAsync.swift
//  SwiftConcurrency
//
//  Created by Hari on 04/12/24.
//

import SwiftUI

//MARK: - Data Manager / Image Loader
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
    
    /// Method: downlaodImageWithCompletionHandlerResultEnum
    /// - Parameters:
    ///   - url: URL used to fetch the data
    ///   - completionHandler: Once event is done it automatically, return the result enum with UIImage else errors
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
    
    //best way to do!
    func downloadImageWithAsync() async throws -> UIImage?{
        do{
            let (data, _) = try await URLSession.shared.data(from: url, delegate:nil)
            //validate the response like other methods how it use the guard for it
            let image = UIImage(data: data)
            return image
        }
        catch{
            throw error
        }
    }
}
//MARK: - ViewModel

class DownloadImgAsyncVM: ObservableObject {
    @Published var image: UIImage?
    let url = URL(string: "https://picsum.photos/200")!
    
    let dataManager: DownloadImgAsyncDataManager = DownloadImgAsyncDataManager()
    
    //DirectWay
    func fetchImage() {
        self.image = UIImage(systemName: "heart.fill")
    }
    
    
    
    //WithCompletionHandler
    func fetchImageWithCompletionHandler() {
        self.dataManager.downlaodImageWithCompletionHandler {[weak self] image, error in
            DispatchQueue.main.async {
                self?.image = image
            }
            
        }
    }
    //WithCompletinHandler+ResultEnum
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
    //WithCleanWay! Async-Await-Task when you're in async env use Actor don't go and use the
    func fetchImageWithAsyncTask() async{
        
        //similar to main thread!
        let image = try? await self.dataManager.downloadImageWithAsync()
        await MainActor.run{
            self.image = image
        }
        
    }
    
}

//MARK: - View (SwiftUI)
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
                Task{
                    await viewModel.fetchImageWithAsyncTask()
                }
            }.padding()
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .onAppear {
            Task{
                await viewModel.fetchImageWithAsyncTask()
            }
            
        }
        
        
    }
}


#Preview {
    DownloadImgAsync()
}
