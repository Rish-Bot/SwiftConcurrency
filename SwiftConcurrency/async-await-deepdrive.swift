//
//  async-await-deepdrive.swift
//  SwiftConcurrency
//
//  Created by Hari on 05/12/24.
//

import SwiftUI
class asyncAwaitDeepdiveVM : ObservableObject {
    @Published var dataArray : [String] = []
    
    func addData(){
        dataArray.append("Welcome to deepDive into Async-Await")
    }
    
    func addAuthor1() async throws {
        dataArray.append("Author1")
        
    }
}

struct async_await_deepdive: View {
    @StateObject private var viewModel =  asyncAwaitDeepdiveVM()
    var body: some View {
        List{
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear{
            viewModel.addData()
            Task{
                try? await viewModel.addAuthor1()
            }
        }
        
        
    }
}

#Preview {
    async_await_deepdive()
}

/*
 Notes: Async-Await
 It's more modern in ios concurrency you often see these terms additionally you could see the Task & error handling part inside it.
 
 Since both the Async-Await is there it's no necessary it always run in the main thread some action may run in background thread also.
 
 
 */
