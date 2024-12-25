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
    
    func addAuthor1() async  {
        try? await Task.sleep(for: .seconds(1))
        print(Task.currentPriority)

        await MainActor.run {
            dataArray.append("Author1")
            print(Thread.current.isMainThread)
        }
        
        
    }
    func addAuthor2() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        print(Task.currentPriority)
        print(Thread.current.isMainThread)
        dataArray.append("Author2")
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
                 await viewModel.addAuthor1()
                await viewModel.addAuthor2()
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
 
 
 * All the task are async in nature
 * Always use actor in func with async and await: don't use dispatch queues even you could do that!
 * await is gonna wait till the line of code is running and then only rest of the code will run it act as a suspend point
 * await it's not necessary to run the code in the BG or main thread it choose on it's own use the actor if you wanna control the thread execution or you can use!
 */
