//
//  TaskInAsyncAwait.swift
//  SwiftConcurrency
//
//  Created by Hari on 07/12/24.
//

import SwiftUI

struct TaskInAsyncAwait: View {
    var body: some View {
        
        VStack{
            
        }.onAppear{
            Task{
                
            }
        }
        
        
    }
        
}

#Preview {
    TaskInAsyncAwait()
}


/*
 Notes :)
 >>  Task yield : it's a wait yield and execute next all the things
 >>  You can add the detach task to add the detachment to the praent task
 >>  Don't use the detach task if it's possible.
 >>  Task cancel also a great way to cancel suppose if the call is working when it's not necessary at all -
 >> .task{ } in SwiftUI automatically cancel task if the view disappears automatically.
 >> check for cancellation for Cancellation() to externally somethings goes wrong on the app at any point of time.
 
 >> task comes with bunch of API's most useful
    1. Task.sleep
    2. Task.yield
    3. Task.cancel
    4. Task.iscancelled
    5. Task.value
    6. Task.detached
 
 >> Async let creates a promises and wait till all the task get complete and give you the value if you want multiple task result at the time you can go with it
 
 >> You can add the async await to a computed property by Keeping async in the get property of computed one
    Example:
        var computedProperty : Organisation {
            get async {
                await networkcall
            }
        }
 */
